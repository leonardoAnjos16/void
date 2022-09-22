//
//  Turma.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 06/09/22.
//

import SwiftUI

struct Turma: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Detalhes")) {
                    DetailCard(title: "Nome", value: "Desenvolvimento iOS")
                    DetailCard(title: "Descrição", value: "Programação com Swift")
                    DetailCard(title: "Período", value: "2022.1")
                    DetailCard(title: "Código", value: "6X3DZ9")
                }
                
                Section(header: Text("Tópicos")) {
                    TopicCard(name: "Variáveis", from: Date.now, to: Date.now, progress: 0.98)
                    TopicCard(name: "Condicionais e Lógica", from: Date.now, to: Date.now, progress: 0.74)
                    TopicCard(name: "Loops", from: Date.now, to: Date.now, progress: 0.52)
                }
                
                Section(header: Text("Alunos")) {
                    StudentCard(name: "Kauê Ferreira Alves")
                    StudentCard(name: "Yasmin Santos Araújo")
                    StudentCard(name: "Gabrielle Sousa Dias")
                    StudentCard(name: "Nicolas Lima Fernandes")
                }
            }
            .listStyle(.sidebar)
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
        NavigationLink(destination: Student(name: name)) {
            HStack {
                Image("Plant")
                Text(name)
            }
        }
        
    }
}

struct Turma_Previews: PreviewProvider {
    static var previews: some View {
        Turma()
    }
}
