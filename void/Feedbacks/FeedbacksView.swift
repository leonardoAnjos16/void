//
//  Feedbacks.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 06/09/22.
//

import SwiftUI

struct FeedbacksView: View {
    
    let items: [Feedback] = [
        Feedback(content: Message(author: "Yasmin Santos Araújo", message: "Gostei bastante da aula, acho que foi em um ritmo legal.", time: Date.now), threadMessages: [Message(author: "Livia", message: "Obrigado pelo feedback, vou tentar manter esse ritmo :)", time: Date.now)]),
        Feedback(content: Message(author: "Kauê Ferreira Alves", message: "Me senti um pouco perdido. Acho que seria melhor se tivessem mais exemplos na aula.", time: Date.now), threadMessages: [])
    ]
    
    
    @State var text = ""
    var body: some View {
        NavigationView {
            VStack{
                Rectangle()
                    .frame(height: 0)
                    .background(Color("screen"))
                    .navigationBarTitle("Feedbacks", displayMode: .inline)
                List {
                    ForEach(filteredResult, id: \.content.time){ item in
                        FeedbackCard(feedback: item)
                    }
                }
                .listStyle(.plain)
                .background(Color.white)
//                .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Buscar")
            }
        }
    }
    
    var filteredResult: [Feedback] {
        if items.isEmpty {
            return []
        } else if text == "" {
            return items
        } else {
            return items.filter { feedback in
                feedback.content.author.contains(text)
            }
        }
    }
}

struct Feedbacks_Previews: PreviewProvider {
    static var previews: some View {
        FeedbacksView()
    }
}
