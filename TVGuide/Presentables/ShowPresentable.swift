import Foundation

struct ShowPresentable {
    let id: Int?
    let name: String
    let type: String
    let language: String
    let genres: String
    let status: String
    let releaseYear: String
    let rating: String
    let image: URL?
    let summary: String
    var episodes: EpisodesBySeason?
    
    init(_ show: Show) {
        id = show.id
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

struct EpisodesBySeason {
    var episodeList: [[EpisodePresentable]]
    
    init(list: [[EpisodePresentable]] ) {
        self.episodeList = list
    }
    
    var numberOfSections: Int {
        return episodeList.count
    }
    
    func titleBysection(section: Int) -> String {
        return "Season \(section + 1)"
    }
    
    func numberOfRowsBy(section: Int) -> Int {
        return episodeList[section].count
    }
    
    func numberOfEpisodes() -> String {
        let episodesFlattened = episodeList.flatMap{ $0 }
        if !episodesFlattened.isEmpty {
            let episodeAmount = String(episodesFlattened.count)
            return episodeAmount
        } else {
            return "n/a"
        }
    }
    
}
