import Foundation

struct Episode {
    let id: Int?
    let url: String?
    let name: String?
    let season, number: String?
    let airdate: Date?
    let runtime: String?
    let image: String?
    let summary: String?
    let links: EpisodeLinks?
}

enum Airtime: String {
    case the2100 = "21:00"
    case the2200 = "22:00"
    case unknown = "n/a"
}

struct EpisodeImage {
    let medium, original: String?
}

struct EpisodeLinks {
    let linksSelf: SelfClass?
}

struct SelfClass {
    let href: String?
}
