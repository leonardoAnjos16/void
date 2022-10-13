//
//  Student.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 15/09/22.
//

import SwiftUI

struct StudentView: View {
    var student: Student
    
    var body: some View {
        List {
            Section(header: Text("Auto-avaliação")) {
                ForEach(student.topics) { topic in
                    TopicCard(topic: topic)
                }
            }
            
            Section(header: Text("Feedback")) {
                ForEach(student.feedbacks) { feedback in
                    FeedbackCard(feedback: feedback)
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle(student.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Student_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(student: Student(name: "Matheus Felipe"))
    }
}
