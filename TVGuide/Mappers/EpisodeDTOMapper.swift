import Foundation

struct EpisodeDTOMapper {
  
  static func map(_ dto: EpisodeDTO) -> Episode {
    
    return Episode (
        id: dto.id!,
        url: dto.url ?? "n/a",
        name: dto.name ?? "n/a",
        season: "\(String(describing: dto.season))" ,
        number: "\(String(describing: dto.number))" ,
        airdate: "\(String(describing: dto.airdate))" ,
        runtime: "\(String(describing: dto.runtime))" ,
        image: dto.image?.original ?? "no image",
        summary: dto.summary ?? "n/a",
        links: EpisodeLinks(linksSelf: SelfClass(href: dto.links?.linksSelf?.href ?? "n/a"))
    )
  }
}
