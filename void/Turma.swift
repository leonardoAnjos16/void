//
//  Turma.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 06/09/22.
//

import SwiftUI

struct Turma: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: FeedbacksView()
                            .navigationBarTitleDisplayMode(.inline))
            {
                Text("move to Feedbacks")
            }
        }
    }
}

struct Turma_Previews: PreviewProvider {
    static var previews: some View {
        Turma()
    }
}
