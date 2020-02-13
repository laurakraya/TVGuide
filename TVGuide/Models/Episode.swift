import Foundation

struct Episode: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let season, number: Int?
    let airdate: String?
    //let airtime: Airtime
    //let airstamp: Date
    let runtime: Int?
    let image: EpisodeImage?
    let summary: String?
    let links: EpisodeLinks?

//    enum CodingKeys: String, CodingKey {
//        case id, url, name, season, number, airdate, airtime, airstamp, runtime, image, summary
//        case links = "_links"
//    }
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, airdate, runtime, image, summary
        case links = "_links"
    }
}

enum Airtime: String, Codable {
    case the2100 = "21:00"
    case the2200 = "22:00"
}

struct EpisodeImage: Codable {
    let medium, original: String?
}

struct EpisodeLinks: Codable {
    let linksSelf: SelfClass?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

struct SelfClass: Codable {
    let href: String?
}

typealias EpisodeList = [Episode]
