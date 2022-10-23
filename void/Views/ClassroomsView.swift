
import SwiftUI
import CoreData

struct ClassroomsView: View {
    @StateObject var viewModel = ClassroomsViewModel()
    @State private var presentNewClassroom = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.classrooms) { classroom in
                        ClassroomCard()
                            .environmentObject(classroom)
                    }
                    .onDelete(perform: viewModel.deleteClassrooms)
                    .onMove(perform: viewModel.moveClassrooms)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("Classrooms")
            .toolbar {
                Button(action: { presentNewClassroom.toggle() }) {
                    Label("New Classroom", systemImage: "plus")
                }
                .fullScreenCover(isPresented: $presentNewClassroom) {
                    ClassroomView(isCreating: true)
                        .environmentObject(viewModel.newClassroom())
                }
                
                if !viewModel.classrooms.isEmpty {
                    EditButton()
                }
            }
        }
        .environmentObject(viewModel)
    }
}

struct ClassroomCard: View {
    @EnvironmentObject var classroom: Classroom
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationLink(destination: {
            ClassroomTabsView()
                .environmentObject(classroom)
        }) {
            VStack(alignment: .leading, spacing: 4) {
                Text(classroom.name ?? "")
                
                Group {
                    Text(classroom.desc ?? "")
                    Text("\(classroom.semester ?? "")" +
                         (classroom.semester != "" && classroom.location != "" ? " · " : "") +
                         "\(classroom.location ?? "")")
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
    }
}
