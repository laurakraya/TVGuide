import Foundation

class StringManager {
    
    static func getStrFromArrOfStr(_ strArr: [String]?) -> String? {

        var resultStr = ""

        guard let sa = strArr else {
            return nil
         }

         for s in sa {
            
            if s != sa[0] {
                resultStr += ", \(s)"
            } else {
                resultStr += s
            }
            
         }

        return resultStr
    }
    
    static func optionalIntToStr (_ int: Int?) -> String? {
        
        guard let integer = int else {
            return nil
        }
        
        let str = String(integer)
        
        return str
        
    }
}
