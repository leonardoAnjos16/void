//
//  Feedback.swift
//  void
//
//  Created by Robson Oliveira on 06/10/22.
//

import Foundation

class Message {
    var author: String = ""
    var message: String = ""
    var time: Date = Date()
    
    init(author: String = "", message: String = "", time: Date = Date()) {
        self.author = author
        self.message = message
        self.time = time
    }
}

class Feedback: Identifiable {
    var id = UUID()
    var content: Message = Message()
    var threadMessages: [Message] = []
    
    init(content: Message = Message(), threadMessages: [Message] = []) {
        self.content = content
        self.threadMessages = threadMessages
    }
}
