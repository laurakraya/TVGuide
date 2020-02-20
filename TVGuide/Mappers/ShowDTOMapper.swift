import Foundation

struct ShowDTOMapper {
  
  static func map(_ dto: ShowDTO) -> Show {
    
    return Show(
                id: dto.id,
                name: dto.name,
                type: dto.type,
                language: dto.language,
                genres: dto.genres,
                status: dto.status,
                premiered: dto.premiered,
                rating: formatRating(ratingDTO: dto.rating),
                image: dto.image?.medium,
                summary: dto.summary
    )
  }
    
    static func formatRating(ratingDTO: RatingDTO?) -> String? {
        
        if let rating = ratingDTO?.average {
            
            let ratingStr = String(rating)
            
            return ratingStr
        }
        return nil
    }
    
}

