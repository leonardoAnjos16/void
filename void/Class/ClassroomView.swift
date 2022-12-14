//
//  Turma.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 06/09/22.
//

import SwiftUI

struct ClassroomView: View {
    @State var showAddTopic = false
    @StateObject var classroomViewModel = ClassroomViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Detalhes")) {
                    DetailCard(title: "Nome", value: classroomViewModel.classroom.name)
                    DetailCard(title: "Descrição", value: classroomViewModel.classroom.description)
                    DetailCard(title: "Período", value: classroomViewModel.classroom.semester)
                    DetailCard(title: "Código", value: classroomViewModel.classroom.code, editable: false)
                }
                
                Section(
                    header: Text("Tópicos"),
                    footer: Button("Adicionar Tópico", action: { showAddTopic = true })
                        .foregroundColor(.blue)
                ) {
                    ForEach(classroomViewModel.classroom.topics) { topic in
                        TopicCard(topic: topic)
                    }
                }
                .listRowSeparator(.hidden)
                
                Section(header: Text("Alunos")) {
                    ForEach(classroomViewModel.classroom.students) { student in
                        StudentCard(student: student)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Turma")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showAddTopic) {
            AddTopicView(isActive: $showAddTopic)
                .environmentObject(classroomViewModel)
        }
    }
}

struct DetailCard: View {
    var title: String
    @State var value: String
    var editable = true
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if editable {
                TextField("", text: $value).fixedSize()
            } else {
                Text(value).foregroundColor(.gray)
            }
        }
    }
}

struct StudentCard: View {
    var student: Student
    
    var plant: String {
        var imageSize = "very-small"
        if student.score > 0.75 {
            imageSize = "big"
        } else if student.score > 0.5 {
            imageSize = "medium"
        } else if student.score > 0.25 {
            imageSize = "small"
        }
        
        return "plant-\(imageSize)"
    }
    
    var body: some View {
        NavigationLink(destination: StudentInfoView(student: student)) {
            HStack {
                Image(plant)
                Text(student.name)
            }
        }
    }
}

struct Turma_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomView()
    }
}
