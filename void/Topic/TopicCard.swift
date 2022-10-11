//
//  TopicCard.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 11/10/22.
//

import SwiftUI

struct TopicCard: View {
    var topic: Topic
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(topic.name).font(.system(size: 18))
            Spacer()
            
            HStack {
                Text(dateToString(date: topic.from)).font(.system(size: 12)).foregroundColor(.gray)
                Text("até").font(.system(size: 12)).foregroundColor(.gray)
                Text(dateToString(date: topic.to)).font(.system(size: 12)).foregroundColor(.gray)
            }
            
            HStack {
                ProgressView(value: topic.progress)
                Text("\(topic.progress * 100, specifier: "%.0f")%")
            }
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM. YYYY"
        return formatter.string(from: date)
    }
}

struct TopicCard_Previews: PreviewProvider {
    static var previews: some View {
        TopicCard(topic: Topic(name: "Variáveis", from: Date.now, to: Date.now, progress: 0.5))
    }
}
