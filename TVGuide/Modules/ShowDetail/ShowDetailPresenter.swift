import Foundation
import UIKit

protocol ShowDetailPresenterProtocol: class {

    func displayShow(show: ShowPresentable, summary: NSAttributedString)

}

class ShowDetailPresenter {

    weak var view: ShowDetailPresenterProtocol?
    
    var interactor: ShowDetailInteractor?
    var router: ShowDetailRouter?
    var show: ShowPresentable?
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
        
        getEpisodes(show)
        
    }

    func getEpisodes(_ show: ShowPresentable) {
        
        interactor?.fetchEpisodes(show: show)
        
    }
    
    func addEpisodeInfoToShow(_ episodes: [EpisodePresentable]) {
        
        let episodeList = episodesBySeason(episodes)
        show?.episodes = EpisodesBySeason.init(list: episodeList)
        
    }
    
    func EpisodestoEPresentables(episodes: [Episode]) {
        
        var ep = [EpisodePresentable]()
        
        episodes.forEach({
            ep.append(EpisodePresentable.init($0))
        })
        
        self.episodesPresentables = ep
        
    }
    
    func episodesBySeason(_ episodes: [EpisodePresentable]) -> [[EpisodePresentable]] {
        
        let seasons = episodes.map({ $0.season }).reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
        
        var episodesBySeason = [[EpisodePresentable]]()
        
        for season in seasons {
        
            let episodesInSeason = episodes.filter({ $0.season == season })
            episodesBySeason.append(episodesInSeason)
            
        }
        
        return episodesBySeason
        
    }

}

extension ShowDetailPresenter: SDInteractorToSDPresenter {
    
    func didRespond(episodes: [Episode]) {
        
        guard let show = self.show else {
            return
        }
        
        EpisodestoEPresentables(episodes: episodes)
        addEpisodeInfoToShow(self.episodesPresentables)
        view?.displayShow(show: show, summary: self.summary)
    }

}
