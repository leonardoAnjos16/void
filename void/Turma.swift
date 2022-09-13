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
                    
                }
                
                Section(header: Text("Alunos")) {
                    StudentCard(name: "Kauê Ferreira Alves")
                    StudentCard(name: "Yasmin Santos Araújo")
                    StudentCard(name: "Gabrielle Sousa Dias")
                    StudentCard(name: "Nicolas Lima Fernandes")
                }
            }
        }
//        ScrollView {
//            VStack {
//                Text("Turma").bold()
//
//                HStack {
//                    Text("Detalhes").padding()
//                    Spacer()
//                }
//
//                List {
//                    DetailCard(title: "Nome", value: "Desenvolvimento iOS")
//                    DetailCard(title: "Descrição", value: "Programação com Swift")
//                    DetailCard(title: "Período", value: "2022.1")
//                    DetailCard(title: "Código", value: "6X3DZ9")
//                }
//
//                HStack {
//                    Text("Tópicos").padding()
//                    Spacer()
//                }
//
//                HStack {
//                    Text("Alunos").padding()
//                    Spacer()
//                }
//
//                List {
//                    AlunoCard(name: "Kaue Ferreira Alves")
//                    AlunoCard(name: "Yasmin Santos Araujo")
//                    AlunoCard(name: "Gabrielle Sousa Dias")
//                    AlunoCard(name: "Nicolas Lima Fernandes")
//                }
//
//                Spacer()
//            }
//        }
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
        VStack {
            Text(name)
//            Text(from.description())
        }
    }
}

struct StudentCard: View {
    var name: String
    
    var body: some View {
        Text(name)
    }
}

struct Turma_Previews: PreviewProvider {
    static var previews: some View {
        Turma()
    }
}
