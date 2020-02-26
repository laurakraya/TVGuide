import Foundation

class StringManager {
    
    static func getStrFromArrOfStr(_ strArr: [String]?) -> String? {

        var resultStr = ""

        guard let stringArray = strArr else {
            return nil
         }

         for str in stringArray {
            
            if str != stringArray[0] {
                resultStr += ", \(str)"
            } else {
                resultStr += str
            }
            
         }

        return resultStr
    }
    
    static func optionalIntToStr(_ int: Int?) -> String? {
        
        guard let integer = int else {
            return nil
        }
        
        let str = String(integer)
        
        return str
        
    }
    
    static func StrToAttributedStr(_ str: String?) -> NSAttributedString? {
        
        guard let string = str else {
            return nil
        }
        
        var attrString = NSAttributedString.init(string: " ")
        let data = Data(string.utf8)
        if let attributedString = try? NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            attrString = attributedString
        }

        return attrString
        
    }
}
