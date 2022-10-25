//
//  SwitchScreenView.swift
//  void
//
//  Created by Heitor Santos on 22/10/22.
//

import SwiftUI

struct SwitchScreenView: View {
    var body: some View {
        NavigationView {
            VStack{
                List {
                    NavigationLink(destination: TeacherView()) { Text("Tela do Professor") }
                    NavigationLink(destination: StudentView()) { Text("Tela do Aluno") }
                }
                .listStyle(.sidebar)
                .navigationTitle("Cultivate")
                .navigationBarTitleDisplayMode(.inline)
                
            }
        }
    }
}

struct SwitchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchScreenView()
    }
}
