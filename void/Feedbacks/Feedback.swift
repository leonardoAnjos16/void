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

class Feedback {
    var content: Message = Message()
    var id: Int = 0
    var threadMessages: [Message] = []
    
    init(content: Message = Message(), id: Int = 0, threadMessages: [Message] = []) {
        self.content = content
        self.id = id
        self.threadMessages = threadMessages
    }
}
