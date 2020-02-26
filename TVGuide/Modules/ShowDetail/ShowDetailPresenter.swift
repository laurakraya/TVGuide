import Foundation
import UIKit

protocol ShowDetailPresenterProtocol: class {

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

    public func viewDidLoad() {
        
        guard let show = self.show else {
            return
        }
        
        if let showDescription = StringManager.StrToAttributedStr(show.summary) {
            self.summary = showDescription
        }
        
        view?.displayShow(show: show, summary: summary)
        getEpisodes()
        
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
        
        episodes.forEach({
            ep.append(EpisodePresentable.init($0))
        })
        
        self.episodesPresentables = ep
        
    }

}
