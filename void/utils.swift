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
