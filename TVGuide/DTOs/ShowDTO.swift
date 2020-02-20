import Foundation

// MARK: - ShowListElement
struct ShowDTO: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let premiered: Date?
    let officialSite: String?
    let schedule: ScheduleDTO?
    let rating: RatingDTO?
    let weight: Int?
    let network, webChannel: NetworkDTO?
    let externals: ExternalsDTO?
    let image: ImageDTO?
    let summary: String?
    let updated: Int?
    let links: LinksDTO?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, premiered, officialSite, schedule, rating, weight, network, webChannel, externals, image, summary, updated
        case links = "_links"
    }
}
// MARK: - Externals
struct ExternalsDTO: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct ImageDTO: Codable {
    let medium, original: String?
}

// MARK: - Links
struct LinksDTO: Codable {
    let linksSelf, previousepisode: NextepisodeDTO?
    let nextepisode: NextepisodeDTO?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

// MARK: - Nextepisode
struct NextepisodeDTO: Codable {
    let href: String?
}

// MARK: - Network
struct NetworkDTO: Codable {
    let id: Int?
    let name: String?
    let country: CountryDTO?
}

// MARK: - Country
struct CountryDTO: Codable {
    let name: NameDTO?
    let code: CodeDTO?
    let timezone: TimezoneDTO?
}

enum CodeDTO: String, Codable {
    case ca = "CA"
    case fr = "FR"
    case gb = "GB"
    case jp = "JP"
    case us = "US"
}

enum NameDTO: String, Codable {
    case canada = "Canada"
    case france = "France"
    case japan = "Japan"
    case unitedKingdom = "United Kingdom"
    case unitedStates = "United States"
}

enum TimezoneDTO: String, Codable {
    case americaHalifax = "America/Halifax"
    case americaNewYork = "America/New_York"
    case asiaTokyo = "Asia/Tokyo"
    case europeLondon = "Europe/London"
    case europeParis = "Europe/Paris"
}

// MARK: - Rating
struct RatingDTO: Codable {
    let average: Double?
}

// MARK: - Schedule
struct ScheduleDTO: Codable {
    let time: String?
    let days: [DayDTO]?
}

enum DayDTO: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}

typealias ShowListDTO = [ShowDTO]?
