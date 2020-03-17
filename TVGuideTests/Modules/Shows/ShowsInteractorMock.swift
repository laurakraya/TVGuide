import Foundation

class ShowsInteractorMock: ShowsInteractor {
    
    override func fetchShows() {
        
        var shows = [Show]()
        
        let networkManager = NetworkManagerMock()
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
    
    override func searchShows(_ searchStr: String) {
        
        var shows = [Show]()
        
        let networkManager = NetworkManagerMock()
        networkManager.searchShows(search: searchStr) { [weak self] (showsList) in
            
            guard let showSearchResultListDTO = showsList else {
                return
            }
            
            showSearchResultListDTO.forEach({
                if let showDTO = $0.show {
                   shows.append(ShowDTOMapper.map(showDTO))
                }
            })

            self?.presenter?.didRespond(shows: shows)
            
        }
    }
}
