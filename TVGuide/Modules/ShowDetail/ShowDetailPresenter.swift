import Foundation
import UIKit

protocol ShowDetailPresenterProtocol: class {

    func displayShow(show: ShowPresentable, summary: NSAttributedString)

    func displayEpisodes(episodes: [EpisodePresentable])

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
        
        view?.displayShow(show: show, summary: summary)
        getEpisodes(show)
        
    }

    func getEpisodes(_ show: ShowPresentable) {
        
        interactor?.fetchEpisodes(show: show)
        
    }
    
    func EpisodestoEPresentables(episodes: [Episode]) {
        
        var ep = [EpisodePresentable]()
        
        episodes.forEach({
            ep.append(EpisodePresentable.init($0))
        })
        
        self.episodesPresentables = ep
        
    }
    
    func printEpisodesBySeason(_ episodes: [EpisodePresentable]) {
        
        let episodesBySeason = Dictionary(grouping: episodes, by: { $0.season! })
        
        let episodesBySeasonSorted = episodesBySeason.sorted { $0.0 < $1.0 } .map { $0 }
        
        episodesBySeasonSorted.forEach({
            print("------------------ Season \($0.key) -----------------")

            $0.value.forEach({
                if let episodeName = $0.name {
                    print(episodeName)
                }
            })
        })
        
        //PARA MAÑANA: CONTENT SIZE OF TABLE VIEW PARA PROBLEMAS DE SCROLL
    }

}

extension ShowDetailPresenter: SDInteractorToSDPresenter {
    
    func didRespond(episodes: [Episode]) {
        
        EpisodestoEPresentables(episodes: episodes)
        printEpisodesBySeason(self.episodesPresentables)
        view?.displayEpisodes(episodes: self.episodesPresentables)
        
    }

}
