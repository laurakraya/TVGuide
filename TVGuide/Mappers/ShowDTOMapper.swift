import Foundation

struct ShowDTOMapper {
  
  static func map(_ dto: ShowDTO) -> Show {
    
    return Show(
                id: dto.id!,
                name: dto.name ?? "n/a",
                type: TypeEnum(rawValue: dto.type?.rawValue ?? "n/a") ?? .unknown,
                language: Language(rawValue: dto.language?.rawValue ?? "n/a") ?? .unknown,
                genres: resolveGenres(genresDTO: dto.genres ?? [GenreDTO]()),
                status: Status(rawValue: dto.status?.rawValue ?? "n/a") ?? .unknown,
                premiered: dto.premiered ?? "n/a",
                rating: formatRating(ratingDTO: dto.rating),
                image: dto.image?.medium ?? "no image",
                summary: dto.summary ?? "n/a"
    )
  }
    
    static func resolveGenres(genresDTO: [GenreDTO]) -> [Genre] {
        
        var genres = [Genre]()
        
        for g in genresDTO {
            if let genre = Genre(rawValue: g.rawValue) {
               genres.append(genre)
            }
        }
        
        return genres
    }
    
    static func formatRating(ratingDTO: RatingDTO?) -> String {
        
        if let rating = ratingDTO?.average {
            
            let ratingStr = String(rating)
            
            return ratingStr
        }
        return "n/a"
    }
}

