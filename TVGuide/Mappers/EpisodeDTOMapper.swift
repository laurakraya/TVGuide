import Foundation

struct EpisodeDTOMapper {
  
  static func map(_ dto: EpisodeDTO) -> Episode {
    
    return Episode (
        id: dto.id,
        url: dto.url,
        name: dto.name,
        season: "\(dto.season)" ,
        number: "\(dto.number)" ,
        airdate: "\(dto.airdate)" ,
        runtime: "\(dto.runtime)" ,
        image: dto.image?.original,
        summary: dto.summary,
        links: EpisodeLinks(linksSelf: SelfClass(href: dto.links?.linksSelf?.href))
    )
  }
}
