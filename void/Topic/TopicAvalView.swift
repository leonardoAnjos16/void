//
//  TopicAvalView.swift
//  void
//
//  Created by Heitor Santos on 12/10/22.
//

import SwiftUI

struct TopicAvalView: View {
    var title: String
    @State var learn: Double
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width: 100, alignment: .leading)
            Slider(
                value: $learn,
                in: 0...100
            )
            Text(String(format: "%.0f", learn)+"%")
        }
    }
}

struct TopicAvalView_Previews: PreviewProvider {
    static var previews: some View {
        TopicAvalView(title: "Prototipação", learn: 50)
    }
}
