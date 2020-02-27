import Foundation
import UIKit

protocol ShowDetailPresenterProtocol: class {

    func displayShow(show: ShowPresentable, summary: NSAttributedString)

    func displayEpisodes(episodes: [EpisodePresentable])

}

class ShowDetailPresenter {

    private let interactor = ShowDetailInteractor()
    weak var view: ShowDetailPresenterProtocol?
    var show: ShowPresentable?
    var episodesPresentables = [EpisodePresentable]()
    var summary = NSAttributedString.init(string: "")

    init(_ show: ShowPresentable) {
        self.show = show
    }

    public func viewDidLoad() {
        
        interactor.presenter = self
        
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
        
        interactor.fetchEpisodes(show: show)
        
    }
    
    func EpisodestoEPresentables(episodes: [Episode]) {
        
        var ep = [EpisodePresentable]()
        
        episodes.forEach({
            ep.append(EpisodePresentable.init($0))
        })
        
        self.episodesPresentables = ep
        
    }

}

extension ShowDetailPresenter: SDInteractorToSDPresenter {
    
    func didRespond(episodes: [Episode]) {
        
        EpisodestoEPresentables(episodes: episodes)
        view?.displayEpisodes(episodes: self.episodesPresentables)
        
    }

}
