import Foundation
import UIKit

protocol ShowDetailPresenterProtocol: UIViewController {

    func displayShow(show: Show)

    func displayEpisodes(episodes: [Episode])

}

class ShowDetailPresenter {

    weak var view: ShowDetailPresenterProtocol?
    var show: Show?
    var episodes = [Episode]()

    init(_ show: Show) {
        self.show = show
    }

    //setup on init
    public func viewDidLoad() {
        guard let show = self.show else {
            return
        }
        view?.displayShow(show: show)
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
            
            self.view?.displayEpisodes(episodes: self.episodes)
        }
    }

}
