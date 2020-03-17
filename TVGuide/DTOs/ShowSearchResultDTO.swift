import Foundation

struct ShowSearchResultDTO: Codable {
    let score: Double?
    let show: ShowDTO?
    
    enum CodingKeys: String, CodingKey {
        case score, show
    }
}

typealias ShowSearchResultListDTO = [ShowSearchResultDTO]?
