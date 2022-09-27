//
//  TopicViewModel.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 27/09/22.
//

import Foundation

class TopicViewModel: ObservableObject {
    @Published var topic = Topic(name: "", from: Date.now, to: Date.now)
}
