//
//  Student.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 15/09/22.
//

import SwiftUI

struct Student: View {
    var name: String
    
    var body: some View {
        Text(name)
    }
}

struct Student_Previews: PreviewProvider {
    static var previews: some View {
        Student(name: "Matheus Felipe")
    }
}
