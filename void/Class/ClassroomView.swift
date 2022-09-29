//
//  Turma.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 06/09/22.
//

import SwiftUI

struct ClassroomView: View {
    @StateObject var classroomViewModel = ClassroomViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Detalhes")) {
                    DetailCard(title: "Nome", value: classroomViewModel.classroom.name)
                    DetailCard(title: "Descrição", value: classroomViewModel.classroom.description)
                    DetailCard(title: "Período", value: classroomViewModel.classroom.semester)
                    DetailCard(title: "Código", value: classroomViewModel.classroom.code)
                }
                
                Section(header: Text("Tópicos")) {
                    ForEach(classroomViewModel.classroom.topics) { topic in
                        TopicCard(name: topic.name, from: topic.from, to: topic.to, progress: topic.progress)
                    }
                    Button("Adicionar Tópico", action: {})
                }
                
                Section(header: Text("Alunos")) {
                    ForEach(classroomViewModel.classroom.students) { student in
                        StudentCard(name: student.name)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Turma")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailCard: View {
    var title: String
    @State var value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField("", text: $value).fixedSize()
        }
    }
}

struct TopicCard: View {
    var name: String
    var from: Date
    var to: Date
    var progress: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(name).font(.system(size: 18))
            Spacer()
            
            HStack {
                Text(dateToString(date: from)).font(.system(size: 12)).foregroundColor(.gray)
                Text("até").font(.system(size: 12)).foregroundColor(.gray)
                Text(dateToString(date: to)).font(.system(size: 12)).foregroundColor(.gray)
            }
            
            HStack {
                ProgressView(value: progress)
                Text("\(progress * 100, specifier: "%.0f")%")
            }
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM. YYYY"
        return formatter.string(from: date)
    }
}

struct StudentCard: View {
    var name: String
    
    var body: some View {
        NavigationLink(destination: StudentView(name: name)) {
            HStack {
                Image("Plant")
                Text(name)
            }
        }
        
    }
}

struct Turma_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomView()
    }
}
