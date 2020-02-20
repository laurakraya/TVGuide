import Foundation

struct EpisodeDTO: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let season, number: Int?
    let airdate: Date?
    let runtime: Int?
    let image: EpisodeImageDTO?
    let summary: String?
    let links: EpisodeLinksDTO?
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, airdate, runtime, image, summary
        case links = "_links"
    }
}

struct EpisodeImageDTO: Codable {
    let medium, original: String?
}

struct EpisodeLinksDTO: Codable {
    let linksSelf: SelfClassDTO?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

struct SelfClassDTO: Codable {
    let href: String?
}

typealias EpisodeListDTO = [EpisodeDTO]?
