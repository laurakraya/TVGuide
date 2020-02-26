import Foundation

class UrlManager {
    
    static func getUrlFromStr(_ str: String?) -> URL? {
        
        guard let string = str else {
            return nil
        }
        
        let url = URL(string: string)
        
        return url
        
    }
}
