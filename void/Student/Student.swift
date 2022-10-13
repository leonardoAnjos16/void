//
//  Student.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 28/09/22.
//

import Foundation

class Student: Identifiable {
    var id = UUID()
    var name: String
    var topics: [Topic] = [
        Topic(name: "Variáveis", from: getDate("09/08/2022"), to: getDate("15/08/2022"), progress: 1.0),
        Topic(name: "Condicionais e Lógica", from: getDate("16/08/2022"), to: getDate("22/08/2022"), progress: 0.22),
        Topic(name: "Loops", from: getDate("23/08/2022"), to: getDate("29/08/2022"), progress: 0.02),
    ]
    var feedbacks: [Feedback] = [
        Feedback(
            content: Message(
                author: "Kaue Ferreira Alves",
                message: "Me senti um pouco perdido. Acho que seria melhor se tivessem mais exemplos na aula",
                time: getDate("28/08/2022")
            )
        )
    ]
    
    init(name: String) {
        self.name = name
    }
    
    var score: Double {
        var score = 0.0
        var totalWeight = 0.0
        
        for topic in topics {
            let weight = Date.now.timeIntervalSince(topic.from) / topic.to.timeIntervalSince(topic.from)
            score += topic.progress * weight
            totalWeight += weight
        }
        
        score /= totalWeight
        return score
    }
}
