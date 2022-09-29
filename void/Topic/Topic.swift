//
//  Topic.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 22/09/22.
//

import Foundation

class Topic: Identifiable {
    var id = UUID()
    var name: String
    var from: Date
    var to: Date
    var progress: Double
    
    init(name: String, from: Date, to: Date, progress: Double = 0.0) {
        self.name = name
        self.from = from
        self.to = to
        self.progress = progress
    }
}
