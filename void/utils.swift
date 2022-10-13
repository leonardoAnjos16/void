//
//  utils.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 11/10/22.
//

import Foundation

func getDate(_ formattedDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.date(from: formattedDate)!
}

func timePast(date: Date) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter.localizedString(for: date, relativeTo: Date())
}
