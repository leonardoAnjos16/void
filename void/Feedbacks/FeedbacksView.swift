//
//  Feedbacks.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 06/09/22.
//

import SwiftUI

struct FeedbacksView: View {
    
    let items: [Feedback] = [
        Feedback(content: Message(author: "Yasmin Santos Araújo", message: "Gostei bastante da aula, acho que foi em um ritmo legal.", time: Date.now), id: 0, threadMessages: [Message(author: "Livia", message: "Obrigado pelo feedback, vou tentar manter esse ritmo :)", time: Date.now)]),
        Feedback(content: Message(author: "Kauê Ferreira Alves", message: "Me senti um pouco perdido. Acho que seria melhor se tivessem mais exemplos na aula.", time: Date.now), id: 1, threadMessages: [])
    ]
    
    
    @State var text = ""
    var body: some View {
            VStack{
                Rectangle()
                    .frame(height: 0)
                    .background(Color("screen"))                 .navigationBarTitle("Feedbacks", displayMode: .inline)
                List {
                    ForEach(filteredResult, id: \.content.time){ item in
                        NavigationLink(destination: FeedbackView(id: item.id)) {
                            HStack{
                                Text("Hi")
                                    .frame(width: 48.0, height: 48.0)
                                VStack(alignment: .leading){
                                    HStack(alignment: .center){
                                        Text(item.content.author)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                        Text("\(timePast(date: item.content.time))")
                                            .foregroundColor(Color(.lightGray))
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.bottom, 1.0)
                                    Text(item.content.message)
                                        .lineLimit(1)
                                        .padding(.bottom, 0.2)
                                        .frame(width: 240, alignment:.leading)
                                    
                                    HStack(alignment: .center){
                                        Image(systemName: "bubble.left")
                                            .foregroundColor(Color(.lightGray))
                                        Text("\(item.threadMessages.count)")
                                            .foregroundColor(Color(.lightGray))
                                    }
                                }
                            }
                        }
                    }
                }.listStyle(.plain)
                    .background(Color.white)
                    .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Buscar")
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
    func timePast(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

struct Feedbacks_Previews: PreviewProvider {
    static var previews: some View {
        FeedbacksView()
    }
}
