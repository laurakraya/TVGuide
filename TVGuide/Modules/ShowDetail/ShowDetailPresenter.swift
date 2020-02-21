import Foundation
import UIKit

protocol ShowDetailPresenterProtocol: UIViewController {

    func displayShow(show: ShowPresentable, summary: NSAttributedString)

    func displayEpisodes(episodes: [EpisodePresentable])

}

class ShowDetailPresenter {

    weak var view: ShowDetailPresenterProtocol?
    var show: ShowPresentable?
    var episodes = [Episode]()
    var episodesPresentables = [EpisodePresentable]()
    var summary = NSAttributedString.init(string: "")

    init(_ show: ShowPresentable) {
        self.show = show
    }

    //setup on init
    public func viewDidLoad() {
        guard let show = self.show else {
            return
        }
        self.summary = setShowDescription(show.summary)
        view?.displayShow(show: show, summary: summary)
        getEpisodes()
    }
    
    func setShowDescription(_ summary: String) -> NSAttributedString {
        
        var showDescription = NSAttributedString.init(string: " ")
        
        let data = Data(summary.utf8)
        if let attributedString = try? NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            showDescription = attributedString
        }

        return showDescription
    }

    func getEpisodes() {
        let networkManager = NetworkManager()
        networkManager.getEpisodeList(id: show?.id) { (episodesList) in

            guard let episodesListDTO = episodesList else {
                return
            }
            
            for episodeDTO in episodesListDTO {
                let episode = EpisodeDTOMapper.map(episodeDTO)
                self.episodes.append(episode)
            }
            
            self.EpisodestoEPresentables(episodes: self.episodes)
            self.view?.displayEpisodes(episodes: self.episodesPresentables)
        }
    }
    
    func EpisodestoEPresentables(episodes: [Episode]) {
        var ep = [EpisodePresentable]()
        
        for episode in episodes {
            let e = mapEpisodetoEP(episode)
            ep.append(e)
        }
        
        self.episodesPresentables = ep
    }
    
    func mapEpisodetoEP (_ episode: Episode) -> EpisodePresentable {
      
      return EpisodePresentable(
                    id: episode.id!,
                    url: episode.url ?? "",
                    name: episode.name ?? "n/a",
                    season: optionalIntToStr(episode.season) ?? "n/a",
                    number: optionalIntToStr(episode.number) ?? "n/a",
                    airdate: dateToStr(episode.airdate) ?? "n/a",
                    runtime: optionalIntToStr(episode.runtime) ?? "n/a",
                    image: episode.image,
                    summary: episode.summary ?? "n/a",
                    links: episode.links ?? "n/a"
      )
        
    }
    
    func dateToStr (_ date: Date?) -> String? {
        
        guard let date = date else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let str = formatter.string(from: date)
        
        return str
    }
    
    func optionalIntToStr (_ int: Int?) -> String? {
        
        guard let integer = int else {
            return nil
        }
        
        let str = String(integer)
        
        return str
    }

}
