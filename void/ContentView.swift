//
//  ContentView.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 06/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            Class().tabItem {
                Image(systemName: "person.3.fill")
                Text("Turma")
            }.tag(1)
            
            Feedbacks().tabItem {
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
