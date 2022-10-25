
import SwiftUI

struct SwitchView: View {
    private var students: [Student] = PersistenceController.shared.fetchAll(sortDescriptors: [
        NSSortDescriptor(key: "name", ascending: true)
    ])
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: {
                    ClassroomsView()
                        .navigationBarHidden(true)
                }) {
                    Text("Teacher")
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
                    }
                }
            }
            .navigationBarTitle("Sign-in as")
            .padding(.top, 16)
        }
    }
}
