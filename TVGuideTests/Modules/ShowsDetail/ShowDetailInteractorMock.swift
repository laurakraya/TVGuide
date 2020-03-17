import Foundation
@testable import TVGuide

class ShowDetailInteractorMock: ShowDetailInteractor {
    
    override func fetchEpisodes(show: ShowPresentable) {
        
        var episodes = [Episode]()
        
        let networkManager = NetworkManagerMock()
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
