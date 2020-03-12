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
        show?.episodeList = episodeList
        episodeAmount(episodeList)
        
    }
    
    func EpisodestoEPresentables(episodes: [Episode]) {
        
        var ep = [EpisodePresentable]()
        
        episodes.forEach({
            ep.append(EpisodePresentable.init($0))
        })
        
        self.episodesPresentables = ep
        
    }
    
    func episodesBySeason(_ episodes: [EpisodePresentable]) -> [[EpisodePresentable]] {
        
        var episodesBySeason = [[EpisodePresentable]]()
        var currentSeason = [EpisodePresentable]()
        var episodesModifiable = episodes
        
        currentSeason.append(episodes[0])
        episodesModifiable.removeFirst()
        
        for episode in episodesModifiable {
            if episode.season == currentSeason.last?.season {
                currentSeason.append(episode)
            } else{
                episodesBySeason.append(currentSeason)
                currentSeason = []
                currentSeason.append(episode)
            }
        }
        episodesBySeason.append(currentSeason)
        
        return episodesBySeason
        
    }
    
    func episodeAmount(_ episodes: [[EpisodePresentable]]?) {
        
        if let episodeList = episodes {
            
            let episodesFlattened = episodeList.flatMap{ $0 }
            show?.episodeAmount = String(episodesFlattened.count)
            
        }

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
