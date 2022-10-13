//
//  ContentView.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 06/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ClassroomView().tabItem {
                Image(systemName: "person.3.fill")
                Text("Turma")
            }.tag(1)
            
            FeedbacksView().tabItem {
                Image(systemName: "message.fill")
                Text("Feedbacks")
            }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
