import Foundation

class DateManager {
    
    static func yearStrFromDate(_ premiered: Date?) -> String? {
        
        guard let date = premiered else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearStr = dateFormatter.string(from: date)

        return yearStr
        
    }
    
    static func dateToStr (_ date: Date?) -> String? {
        
        guard let date = date else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let str = formatter.string(from: date)
        
        return str
        
    }
    
}
