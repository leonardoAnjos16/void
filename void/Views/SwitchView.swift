
import SwiftUI

struct SwitchView: View {
    private var students: [Student] = PersistenceController.shared.fetchAll(sortDescriptors: [
        NSSortDescriptor(key: "name", ascending: true)
    ])
    
    var body: some View {
        NavigationView {
            List {
                Section("Teachers") {
                    NavigationLink(destination: {
                        ClassroomsView()
                            .navigationBarHidden(true)
                    }) {
                        Text("Felipe Soares")
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
                
                Section("Students") {
                    ForEach(students) { student in
                        NavigationLink(destination: {
                            StudentClassroomsView()
                                .navigationBarHidden(true)
                                .environmentObject(StudentClassroomsViewModel(student))
                        }) {
                            Text(student.name ?? "")
                        }
                        .listRowBackground(Color(UIColor.secondarySystemBackground))
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Sign-in as")
            .padding(.top, 16)
        }
    }
}
