import Foundation

struct Show {
    let id: Int
    let name: String
    let type: TypeEnum
    let language: Language
    let genres: [Genre]
    let status: Status
    let premiered: String
    let rating: String
    let image: String
    let summary: String
}

enum Genre: String {
    case action = "Action"
    case adventure = "Adventure"
    case anime = "Anime"
    case comedy = "Comedy"
    case crime = "Crime"
    case drama = "Drama"
    case espionage = "Espionage"
    case family = "Family"
    case fantasy = "Fantasy"
    case history = "History"
    case horror = "Horror"
    case legal = "Legal"
    case medical = "Medical"
    case music = "Music"
    case mystery = "Mystery"
    case romance = "Romance"
    case scienceFiction = "Science-Fiction"
    case sports = "Sports"
    case supernatural = "Supernatural"
    case thriller = "Thriller"
    case war = "War"
    case western = "Western"
    case unknown = "n/a"
}

enum Language: String {
    case english = "English"
    case japanese = "Japanese"
    case unknown = "n/a"
}

enum Status: String {
    case ended = "Ended"
    case running = "Running"
    case toBeDetermined = "To Be Determined"
    case unknown = "n/a"
}

enum TypeEnum: String {
    case animation = "Animation"
    case documentary = "Documentary"
    case reality = "Reality"
    case scripted = "Scripted"
    case talkShow = "Talk Show"
    case unknown = "n/a"
}
