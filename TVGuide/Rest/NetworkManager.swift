import Foundation
import Alamofire

class NetworkManager {

    func getShows(completion: @escaping ([ShowDTO]?) -> Void) {
        let urlString = "http://api.tvmaze.com/shows"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let showsList = try JSONDecoder().decode(ShowListDTO.self, from: data)
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
                    let episodeList = try JSONDecoder().decode(EpisodeListDTO.self, from: data)
                    completion(episodeList)
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
