
import SwiftUI

struct ClassroomView: View {
    @EnvironmentObject var classroomsViewModel: ClassroomsViewModel
    @EnvironmentObject var classroom: Classroom
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    
    @StateObject var topicsViewModel = TopicsViewModel()
    @StateObject var studentsViewModel = StudentsViewModel()
    
    var isEditing: Bool { editMode?.wrappedValue.isEditing ?? false }
    var isCreating: Bool = false
    @State private var presentNewTopic = false
    
    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var semester: String = ""
    @State private var location: String = ""
    @State private var code: String = ""
    private var topics: [Topic] { topicsViewModel.topics(from: classroom) }
    private var students: [Student] { studentsViewModel.students(from: classroom) }
    
    private func viewInit() {
        name = classroom.name ?? ""
        desc = classroom.desc ?? ""
        semester = classroom.semester ?? ""
        location = classroom.location ?? ""
        code = classroom.code ?? ""
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Details") {
                        DetailCard(label: "Name", value: $name, required: true)
                        DetailCard(label: "Description", value: $desc)
                        DetailCard(label: "Semester", value: $semester)
                        DetailCard(label: "Location", value: $location)
                        
                        if !isCreating {
                            DetailCard(label: "Code", value: $code, editable: false)
                        }
                    }
                    .environment(\.editMode, Binding.constant(isEditing || isCreating
                                                              ? EditMode.active
                                                              : EditMode.inactive))
                    
                    Section("Topics") {
                        ForEach(topics) { topic in
                            TopicCard(topic: topic)
                                .deleteDisabled(!isEditing && !isCreating)
                        }
                        .onDelete(perform: { offsets in
                            topicsViewModel.delete(topics: offsets.map({ topics[$0] }))
                        })
                        
                        if topics.isEmpty {
                            Text("No Topics")
                        }
                        
                        if isEditing || isCreating {
                            Button("Add Topic...") { presentNewTopic.toggle() }
                                .sheet(isPresented: $presentNewTopic) { NewTopicView() }
                                .disabled(name.isEmpty)
                        }
                    }
                    
                    if !isCreating {
                        Section("Students") {
                            ForEach(students) { student in
                                StudentCard(student: student)
                            }
                            
                            if students.isEmpty {
                                Text("No Students")
                            }
                        }
                    }
                }
            }
            .navigationTitle(!isCreating ? "Classroom" : "New Classroom")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        classroomsViewModel.discard()
                        
                        if !isEditing {
                            dismiss()
                        } else {
                            viewInit()
                            editMode?.wrappedValue = .inactive
                        }
                    } label: {
                        if !isEditing && !isCreating {
                            Label("Go to Classrooms", systemImage: "chevron.backward")
                                .fontWeight(.semibold)
                                .labelStyle(.iconOnly)
                        } else {
                            Text("Cancel")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEditing || isCreating {
                        Button(isCreating ? "Save" : "Done") {
                            classroomsViewModel.updateClassroom(classroom, name: name,
                                                                desc: desc, semester: semester,
                                                                location: location)
                            
                            if isCreating {
                                dismiss()
                            } else {
                                editMode?.wrappedValue = .inactive
                            }
                        }
                        .disabled(name.isEmpty)
                    } else {
                        Button("Edit") {
                            editMode?.wrappedValue = .active
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .onAppear(perform: viewInit)
        .environmentObject(topicsViewModel)
        .environmentObject(studentsViewModel)
    }
}

struct DetailCard: View {
    @Environment(\.editMode) private var editMode
    
    var label: String
    var value: Binding<String>
    var editable = true
    var required = false
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(label))
                .fixedSize()
            
            HStack {
                if editable && editMode?.wrappedValue == .active {
                    TextField(required ? "Required" : "", text: value,
                              axis: required ? .horizontal : .vertical)
                } else {
                    Spacer()
                    Text(value.wrappedValue)
                        .textSelection(.enabled)
                }
            }
            .multilineTextAlignment(.trailing)
            .foregroundColor(Color.secondary)
        }
    }
}
