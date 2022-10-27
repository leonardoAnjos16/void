
import SwiftUI

struct ClassroomView: View {
    @EnvironmentObject var classroomsViewModel: ClassroomsViewModel
    @EnvironmentObject var topicsViewModel: TopicsViewModel
    @EnvironmentObject var studentsViewModel: StudentsViewModel
    @EnvironmentObject var classroom: Classroom
    @Environment(\.dismiss) private var dismiss
    
    var isCreating: Bool = false
    @State private var isEditing: Bool = false
    @State private var presentNewTopic = false
    
    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var semester: String = ""
    @State private var location: String = ""
    @State private var code: String = ""
    
    private func viewInit() {
        name = classroom.name ?? ""
        desc = classroom.desc ?? ""
        semester = classroom.semester ?? ""
        location = classroom.location ?? ""
        code = classroom.code ?? ""
    }
    
    func goBack() {
            classroomsViewModel.discard()
            
            if !isEditing {
                dismiss()
            } else {
                viewInit()
                isEditing.toggle()
            }
    }
    
    var body: some View {
        NavigationView {
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
                    ForEach(topicsViewModel.topics) { topic in
                        TopicCard(topic: topic)
                            .deleteDisabled(!isEditing && !isCreating)
                    }
                    .onDelete(perform: topicsViewModel.deleteTopics)
                    
                    if topicsViewModel.topics.isEmpty {
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
                        ForEach(studentsViewModel.studentClassrooms) { studentClassroom in
                            StudentCard(studentClassroom: studentClassroom)
                                .disabled(isEditing || isCreating)
                        }
                        
                        if studentsViewModel.studentClassrooms.isEmpty {
                            Text("No Students")
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(!isCreating ? "Classroom" : "New Classroom")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        goBack()
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
                            
                            goBack()
                        }
                        .disabled(name.isEmpty)
                    } else {
                        Button("Edit") {
                            isEditing.toggle()
                        }
                    }
                }
            }
        }
        .onAppear(perform: viewInit)
        .highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
            .onEnded { value in
                if abs(value.translation.height) < abs(value.translation.width) {
                    if abs(value.translation.width) > 50.0 {
                        if value.translation.width > 0 {
                            goBack()
                        }
                    }
                }
            }
        )
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
