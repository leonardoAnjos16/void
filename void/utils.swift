
import Foundation

func dateToString(_ date: Date?, default defaultStr: String = "") -> String {
    if date != nil {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date!)
    }
    
    return defaultStr
}

func timePast(date: Date) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    
    return formatter.localizedString(for: date, relativeTo: Date())
}


extension Date {
    var onlyDate: Date? {
        get {
            var calendar = Calendar.current
            calendar.timeZone = .gmt
            
            return calendar.date(from: calendar.dateComponents([.year, .month, .day], from: self))
        }
    }
}
