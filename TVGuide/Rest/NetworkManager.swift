import Foundation
import Alamofire

class NetworkManager {

    let dateFormat = "yyyy-MM-dd"

    func getShows(completion: @escaping ([ShowDTO]?) -> Void) {
        let urlString = "http://api.tvmaze.com/shows"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = self.dateFormat
                decoder.dateDecodingStrategy = .formatted(formatter)
                let showsList = try decoder.decode(ShowListDTO.self, from: data)
                completion(showsList)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    func getEpisodeList(id: Int?, completion: @escaping ([EpisodeDTO]?) -> Void) {
        if let id = id {
           let urlString = "http://api.tvmaze.com/shows/\(id)/episodes"

            AF.request(urlString).response { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = self.dateFormat
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let episodeList = try decoder.decode(EpisodeListDTO.self, from: data)
                    completion(episodeList)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            }
        }
    }
    
    func searchShows(search: String?, completion: @escaping ([ShowSearchResultDTO]?) -> Void) {
        if let search = search {
            let urlString = "http://api.tvmaze.com/search/shows?q=\(search)"
            AF.request(urlString).response { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let formatter = DateFormatter()
                    formatter.dateFormat = self.dateFormat
                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let showsList = try decoder.decode(ShowSearchResultListDTO.self, from: data)
                    completion(showsList)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            }
        }
    }
}

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
