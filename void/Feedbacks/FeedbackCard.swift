//
//  FeedbackCard.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 13/10/22.
//

import SwiftUI

struct FeedbackCard: View {
    var feedback: Feedback
    
    var body: some View {
        NavigationLink(destination: FeedbackView(id: feedback.id)) {
            HStack{
                Text("Hi")
                    .frame(width: 48.0, height: 48.0)
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Text(feedback.content.author)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        Text("\(timePast(date: feedback.content.time))")
                            .foregroundColor(Color(.lightGray))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.bottom, 1.0)
                    Text(feedback.content.message)
                        .lineLimit(1)
                        .padding(.bottom, 0.2)
                        .frame(width: 240, alignment:.leading)
                    
                    HStack(alignment: .center){
                        Image(systemName: "bubble.left")
                            .foregroundColor(Color(.lightGray))
                        Text("\(feedback.threadMessages.count)")
                            .foregroundColor(Color(.lightGray))
                    }
                }
            }
        }
    }
}

struct FeedbackCard_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackCard(feedback: Feedback())
    }
}
