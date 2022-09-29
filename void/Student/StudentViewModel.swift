//
//  StudentViewModel.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 28/09/22.
//

import Foundation

class StudentViewModel: ObservableObject {
    @Published var student: Student
    
    init(student: Student) {
        self.student = student
    }
}
