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
                shows.append(ShowDTOMapper.map(showDTO))
            }
            
            self?.presenter?.didRespond(shows: shows)
            
        }
    }
    
    func searchShows(_ searchStr: String) {
        
        var shows = [Show]()
        
        let networkManager = NetworkManager()
        networkManager.searchShows(search: searchStr) { [weak self] (showsList) in
            
            guard let showSearchResultListDTO = showsList else {
                return
            }
            
            showSearchResultListDTO.forEach({
                if let showDTO = $0.show {
                   shows.append(ShowDTOMapper.map(showDTO))
                }
            })
            
            print(shows.count)
            shows.forEach({
                print($0.name)
            })
            
        }
    }
}
