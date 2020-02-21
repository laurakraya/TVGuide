import Foundation
import UIKit

protocol ShowDetailPresenterProtocol: UIViewController {

    func displayShow(show: ShowPresentable, summary: NSAttributedString)

    func displayEpisodes(episodes: [Episode])

}

class ShowDetailPresenter {

    weak var view: ShowDetailPresenterProtocol?
    var show: ShowPresentable?
    var episodes = [Episode]()
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
            
            self.view?.displayEpisodes(episodes: self.episodes)
        }
    }

}