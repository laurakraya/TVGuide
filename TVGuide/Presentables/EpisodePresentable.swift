import Foundation

struct EpisodePresentable {
    let id: Int?
    let url: String?
    let name: String?
    let season, number: String?
    let airdate: String?
    let runtime: String?
    let image: String?
    let summary: String?
    let links: String?
    
    init(_ episode: Episode) {
        id = episode.id
        url = episode.url ?? ""
        name = episode.name ?? "n/a"
        season = StringManager.optionalIntToStr(episode.season) ?? "n/a"
        number = StringManager.optionalIntToStr(episode.number) ?? "n/a"
        airdate = DateManager.dateToStr(episode.airdate) ?? "n/a"
        runtime = StringManager.optionalIntToStr(episode.runtime) ?? "n/a"
        image = episode.image
        summary = episode.summary ?? "n/a"
        links = episode.links ?? "n/a"
    }

}
