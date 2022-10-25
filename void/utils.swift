
import Foundation
import SwiftUI

extension Date {
    var onlyDate: Date? {
        get {
            var calendar = Calendar.current
            calendar.timeZone = .gmt
            
            return calendar.date(from: calendar.dateComponents([.year, .month, .day], from: self))
        }
    }
    
    func formatted(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        
        return dateFormatter.string(from: self)
    }
}

protocol DateInterpolation { mutating func appendInterpolation(_: String) }

extension DateInterpolation {
    mutating func appendInterpolation(_ date: Date?, dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .none) {
        appendInterpolation(date?.formatted(dateStyle: dateStyle, timeStyle: timeStyle) ?? "")
    }
}

extension String.StringInterpolation: DateInterpolation {}
extension LocalizedStringKey.StringInterpolation: DateInterpolation {}
