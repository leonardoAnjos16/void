//
//  StudentView.swift
//  void
//
//  Created by Heitor Santos on 29/09/22.
//

import SwiftUI

struct StudentView: View {
    @State private var selected = 1
    @State private var feedback = ""
    @State private var showingAlert = false
    
    func getFeedback() {
        feedback = ""
        showingAlert = true
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    Section(header: Text("Autoavaliação")) {
                        TopicAvalView(title: "Ideação", learn: 0.7)
                        TopicAvalView(title: "Prototipação", learn: 0.3)
                        TopicAvalView(title: "Validação", learn: 0.5)
                        TopicAvalView(title: "Investigação", learn: 0.9)
                    }
                    
                    Section(header: Text("Feedbacks")) {
                        Picker(selection: $selected, label: Text("Tópico")) {
                            Text("Ideação").tag(1)
                            Text("Prototipação").tag(2)
                            Text("Validação").tag(3)
                            Text("Investigação").tag(4)
                        }
                        
                        TextField("Descreva aqui...", text: $feedback).frame(height: 80)
                        Button("Enviar", action:getFeedback)
                            .buttonStyle(.bordered)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .alert("Feedback enviado", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) {}
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
