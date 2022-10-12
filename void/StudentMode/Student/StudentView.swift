//
//  StudentView.swift
//  void
//
//  Created by Heitor Santos on 29/09/22.
//

import SwiftUI

struct StudentView: View {
    @State private var speed = 50.0
    @State private var isEditing = false
    @State private var selected = 1
    @State private var feedback = "bbbbbbbbbbddbbbbb"
    @State private var showingAlert = false
    
    func getFeedback(){
        showingAlert = true
        feedback = ""
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    Section(header: Text("Autoavaliação")){
                        TopicAval(title: "Ideação", value:70)
                        TopicAval(title: "Prototipação", value:30)
                        TopicAval(title: "Validação", value:50)
                        TopicAval(title: "Investigação", value:90)
                    }
                    Section(header: Text("Feedbacks")){
                        Picker(selection: $selected, label: Text("Tópico")) {
                                Text("Ideação").tag(1)
                                Text("Prototipação").tag(2)
                                Text("Validação").tag(3)
                                Text("Investigação").tag(4)
                            }
                        TextField("Descreva aqui...", text: $feedback)
                            .frame(height: 60)
                        Button("Enviar", action:getFeedback)
                            .buttonStyle(.bordered)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .alert("Feedback enviado", isPresented: $showingAlert) {
                                        Button("OK", role: .cancel) { }
                                    }
                        
                    }
                }
                .listStyle(.sidebar)
                .navigationTitle("Desenvolvimento iOS")
                .navigationBarTitleDisplayMode(.inline)
                
            }
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
    }
}


struct TopicAval: View {
    var title: String
    @State var value: Double
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Slider(
                value: $value,
                in: 0...100
            )
        }
    }
}
