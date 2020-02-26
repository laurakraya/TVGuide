import Foundation

class StringManager {
    
    static func getStrFromArrOfStr(_ strArr: [String]?) -> String? {

        var resultStr = ""

        guard let stringArray = strArr else {
            return nil
         }
        
        var arrayStr = stringArray
        
        guard !arrayStr.isEmpty else {
            return nil
        }
        
        resultStr += arrayStr[0]
        arrayStr.removeFirst()
        
        arrayStr.forEach({
            resultStr += ", \($0)"
        })

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
