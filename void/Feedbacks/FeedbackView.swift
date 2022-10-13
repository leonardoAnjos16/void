//
//  Feedback.swift
//  void
//
//  Created by Robson Oliveira on 29/09/22.
//
import SwiftUI

struct FeedbackView: View {
    var id: UUID
    
    @State private var comment: String = ""
    
    @State private var item: Feedback = Feedback(content: Message(author: "Yasmin Santos Araújo", message: "Gostei bastante da aula, acho que foi em um ritmo legal.", time: Date.now), threadMessages: [Message(author: "Livia", message: "Obrigado pelo feedback, vou tentar manter esse ritmo :)", time: Date.now), Message(author: "Livia", message: "Obrigado pelo feedback, vou tentar manter esse ritmo :)", time: Date.now)]);

    
    func getDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
    
    func pushThreadMessage() -> Void {
        item.threadMessages.append(Message(author: "Eu", message: comment, time: Date.now))
    }
    
    
    @State var text = ""
    var body: some View {
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading, spacing: 0){
                    HStack(alignment: .top, spacing: 0){
                        Text(item.content.author)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(getDate(date:item.content.time))
                            .foregroundColor(Color(.lightGray))
                            
                    }
                    HStack(alignment: .top, spacing: 0) {
                        Text(item.content.message)
                        Spacer()
                    }.padding(.vertical, 6)
                    
                    HStack(alignment: .top){
                        Image(systemName: "bubble.left")
                            .foregroundColor(Color(.lightGray))
                        Text("\(item.threadMessages.count)")
                            .foregroundColor(Color(.lightGray))
                        Spacer()
                    }
                }.padding(.horizontal, 16.0)
                    .padding(.vertical, 8.0)
                    .background(Color.white)
                    .cornerRadius(14)
                
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        ForEach(item.threadMessages, id: \.time){ item in
                            Section {
                                VStack{
                                    HStack{
                                        Text(item.author)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                        Text(getDate(date:item.time))
                                            .foregroundColor(Color(.lightGray))
                                            .multilineTextAlignment(.leading)
                                    }
                                    HStack(spacing: 0) {
                                        Text(item.message)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            }.background(Color.white)
                        }.cornerRadius(14)
                        HStack{
                            TextField("Comentar", text: $comment)
                                .onSubmit(pushThreadMessage)
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .frame(width: 28.0, height: 28.0)
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                        .padding(.leading, 12.0)
                        .padding([.top, .bottom, .trailing], 4.0)
                        .background(Color.white)
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color(UIColor.separator), lineWidth: 1)
                        )
                    }.frame(width: 320.0)
                }
                Spacer()
            }.navigationBarTitle("Feedback", displayMode: .inline)
            .padding(.horizontal)
            .background(Color("screen"))
        }
}

struct Feedback_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView(id: UUID())
//        Text("Feedback")
    }
}
