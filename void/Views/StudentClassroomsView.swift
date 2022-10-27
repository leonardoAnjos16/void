
import SwiftUI

struct StudentClassroomsView: View {
    @EnvironmentObject var viewModel: StudentClassroomsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var presentAddClassroom = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.studentClassrooms) { studentClassroom in
                        ClassroomCard(classroom: studentClassroom.classroom!, destination: (
                            StudentClassroomView()
                                .environmentObject(studentClassroom)
                                .environmentObject(TopicsViewModel(studentClassroom.classroom!))
                                .environmentObject(StudentsViewModel(studentClassroom.classroom!))
                                .environmentObject(FeedbacksViewModel(studentClassroom.classroom!))
                        ))
                    }
                    .onDelete(perform: viewModel.deleteClassrooms)
                    .onMove(perform: viewModel.moveClassrooms)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Classrooms")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Sign-in as", systemImage: "chevron.backward")
                            .fontWeight(.semibold)
                            .labelStyle(.iconOnly)
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: { presentAddClassroom.toggle() }) {
                        Label("Add Classroom", systemImage: "plus")
                    }
                    .sheet(isPresented: $presentAddClassroom) {
                        AddClassroomView()
                    }
                    
                    if !viewModel.studentClassrooms.isEmpty {
                        EditButton()
                    }
                }
            }
        }
        .environmentObject(viewModel)
        .highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
            .onEnded { value in
                if abs(value.translation.height) < abs(value.translation.width) {
                    if abs(value.translation.width) > 50.0 {
                        if value.translation.width > 0 {
                            dismiss()
                        }
                    }
                }
            }
        )
    }
}

struct AddClassroomView: View {
    @EnvironmentObject var viewModel: StudentClassroomsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var code = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Code", text: $code)
                }
            }
            .navigationTitle("Add Classroom")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        viewModel.addClassroom(code: code)
                        dismiss()
                    }
                    .disabled(code.isEmpty)
                }
            }
        }
    }
}
