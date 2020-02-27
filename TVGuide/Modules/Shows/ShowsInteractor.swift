import Foundation

protocol ShowsInteractorToShowsPresenter: class {
    
    func didRespond(shows: [Show])
    
}

class ShowsInteractor {
    
    weak var presenter: ShowsInteractorToShowsPresenter?
    
    func fetchShows() {
        
        var shows = [Show]()
        
        let networkManager = NetworkManager()
        networkManager.getShows() { [weak self] (showsList) in
            
            guard let showListDTO = showsList else {
                return
            }
            
            for showDTO in showListDTO {
                let show = ShowDTOMapper.map(showDTO)
                shows.append(show)
            }
            
            self?.presenter?.didRespond(shows: shows)
            
        }
    }
}
