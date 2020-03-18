import Foundation
@testable import TVGuide

class NetworkManagerMock: NetworkManager {
    
    override func getShows(completion: @escaping ([ShowDTO]?) -> Void) {
        
        let showDTO = ShowDTO(id: 1, url: "saraza", name: "saraza", type: "saraza", language: "saraza", genres: ["saraza"], status: "saraza", runtime: 1, premiered: nil, officialSite: "saraza", schedule: nil, rating: nil, weight: 1, network: nil, webChannel: nil, externals: nil, image: nil, summary: "saraza", updated: 1, links: nil)
        
        var showDTOArray = [ShowDTO]()
        showDTOArray.append(showDTO)
        showDTOArray.append(showDTO)
        showDTOArray.append(showDTO)
        showDTOArray.append(showDTO)
        showDTOArray.append(showDTO)
        
        completion(showDTOArray)
        
    }
    
    override func searchShows(search: String?, completion: @escaping ([ShowSearchResultDTO]?) -> Void) {
        
        let showDTO = ShowDTO(id: 1, url: "saraza", name: "saraza", type: "saraza", language: "saraza", genres: ["saraza"], status: "saraza", runtime: 1, premiered: nil, officialSite: "saraza", schedule: nil, rating: nil, weight: 1, network: nil, webChannel: nil, externals: nil, image: nil, summary: "saraza", updated: 1, links: nil)
        
        let showSearchResultDTO = ShowSearchResultDTO(score: 0.0, show: showDTO)
        
        var showSearchResultDTOArray = [ShowSearchResultDTO]()
        showSearchResultDTOArray.append(showSearchResultDTO)
        showSearchResultDTOArray.append(showSearchResultDTO)
        showSearchResultDTOArray.append(showSearchResultDTO)
        
        completion(showSearchResultDTOArray)
    }
    
    override func getEpisodeList(id: Int?, completion: @escaping ([EpisodeDTO]?) -> Void) {
        
        let episodeDTOSeason1 = EpisodeDTO(id: 1, url: "saraza", name: "saraza", season: 1, number: 1, airdate: nil, runtime: nil, image: nil, summary: "saraza", links: nil)
        let episodeDTOSeason2 = EpisodeDTO(id: 1, url: "saraza", name: "saraza", season: 2, number: 1, airdate: nil, runtime: nil, image: nil, summary: "saraza", links: nil)
        
        var episodeDTOArray = [EpisodeDTO]()
        episodeDTOArray.append(episodeDTOSeason1)
        episodeDTOArray.append(episodeDTOSeason1)
        episodeDTOArray.append(episodeDTOSeason1)
        episodeDTOArray.append(episodeDTOSeason2)
        episodeDTOArray.append(episodeDTOSeason2)
        episodeDTOArray.append(episodeDTOSeason2)
        
        completion(episodeDTOArray)
    }
}
