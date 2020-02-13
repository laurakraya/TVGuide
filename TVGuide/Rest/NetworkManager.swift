import Foundation
import Alamofire

class NetworkManager {

    func getShows(completion: @escaping ([Show]?) -> Void) {
        let urlString = "http://api.tvmaze.com/shows"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let showsList = try JSONDecoder().decode(ShowList.self, from: data)
                completion(showsList)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    func getEpisodeList(id: Int?, completion: @escaping ([Episode]?) -> Void) {
        if let id = id {
           let urlString = "http://api.tvmaze.com/shows/\(id)/episodes"

            AF.request(urlString).response { response in
                guard let data = response.data else { return }
                do {
                    let episodeList = try JSONDecoder().decode(EpisodeList.self, from: data)
                    completion(episodeList)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            }
        }
    }
}
