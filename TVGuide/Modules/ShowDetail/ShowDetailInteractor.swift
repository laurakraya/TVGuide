import Foundation

protocol SDInteractorToSDPresenter: class {
    
    func didRespond(episodes: [Episode])
}

class ShowDetailInteractor {
    
    weak var presenter: ShowDetailPresenter?
    
    func fetchEpisodes(show: ShowPresentable) {
        
        var episodes = [Episode]()
        
        let networkManager = NetworkManager()
        networkManager.getEpisodeList(id: show.id) { [unowned self] (episodesList) in

            guard let episodesListDTO = episodesList else {
                return
            }
            
            for episodeDTO in episodesListDTO {
                episodes.append(EpisodeDTOMapper.map(episodeDTO))
            }
            
            self.presenter?.didRespond(episodes: episodes)
            
        }
        
    }
}
