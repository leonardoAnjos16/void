
import SwiftUI

struct ClassroomsView: View {
    @StateObject var viewModel = ClassroomsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var presentNewClassroom = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.classrooms) { classroom in
                        ClassroomCard(classroom: classroom, destination: ClassroomTabsView())
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
                    Button(action: { presentNewClassroom.toggle() }) {
                        Label("New Classroom", systemImage: "plus")
                    }
                    .fullScreenCover(isPresented: $presentNewClassroom) {
                        let classroom = viewModel.newClassroom()
                        
                        ClassroomView(isCreating: true)
                            .environmentObject(classroom)
                            .environmentObject(TopicsViewModel(classroom))
                    }
                    
                    if !viewModel.classrooms.isEmpty {
                        EditButton()
                    }
                }
            }
        }
        .environmentObject(viewModel)
    }
}

struct ClassroomCard<Destination: View>: View {
    @Environment(\.editMode) private var editMode
    
    var classroom: Classroom
    var destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination.environmentObject(classroom)) {
            VStack(alignment: .leading, spacing: 4) {
                Text(classroom.name ?? "")
                
                Group {
                    Text(classroom.desc ?? "")
                    Text((classroom.semester ?? "") +
                         (classroom.semester != "" && classroom.location != "" ? " · " : "") +
                         (classroom.location ?? ""))
                }
                .lineLimit(1)
                .foregroundColor(Color.secondary)
            }
            .padding(.vertical, 8)
        }
        .listRowBackground(Color(UIColor.secondarySystemBackground))
        .disabled(editMode!.wrappedValue.isEditing)
    }
}

struct ClassroomTabsView: View {
    @EnvironmentObject var classroom: Classroom
    
    var body: some View {
        TabView {
            ClassroomView().tabItem {
                Image(systemName: "person.3")
                Text("Classroom")
            }.tag(1)
            
            FeedbacksView().tabItem {
                Image(systemName: "message")
                Text("Feedbacks")
            }.tag(2)
        }
        .navigationBarHidden(true)
        .environmentObject(TopicsViewModel(classroom))
        .environmentObject(StudentsViewModel(classroom))
        .environmentObject(FeedbacksViewModel(classroom))
    }
}
