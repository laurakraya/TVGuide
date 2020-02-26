import Foundation

struct ShowPresentable {
    let id: Int
    let name: String
    let type: String
    let language: String
    let genres: String
    let status: String
    let releaseYear: String
    let rating: String
    let image: URL?
    let summary: String
    
    init(_ show: Show) {
        id = show.id!
        name = show.name ?? "n/a"
        type = show.type ?? "n/a"
        language = show.language ?? "n/a"
        genres = StringManager.getStrFromArrOfStr(show.genres) ?? "n/a"
        status = show.status ?? "n/a"
        releaseYear = DateManager.yearStrFromDate(show.premiered) ?? "n/a"
        rating = show.rating ?? "n/a"
        summary = show.summary ?? "n/a"
        guard let urlString = show.image else { self.image = nil; return }
        image = URL(string: urlString)
    }
}
