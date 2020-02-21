import Foundation
import UIKit

protocol ShowsPresenterToShowsVC: UIViewController {

    func displayShows(_ shows: [ShowPresentable])

}

class ShowsPresenter {

    weak var view: ShowsPresenterToShowsVC?
    var shows = [Show]()
    var showsPresentables = [ShowPresentable]()

    init() {

    }

    func getShows() {
        let networkManager = NetworkManager()
        networkManager.getShows() { (showsList) in
            
            guard let showListDTO = showsList else {
                return
            }
            
            for showDTO in showListDTO {
                let show = ShowDTOMapper.map(showDTO)
                self.shows.append(show)
            }

            self.ShowstoSPresentables(shows: self.shows)
            self.view?.displayShows(self.showsPresentables)
        }
    }
    
    func ShowstoSPresentables(shows: [Show]) {
        var sp = [ShowPresentable]()
        
        for show in shows {
            let s = mapShowtoSP(show)
            sp.append(s)
        }
        
        self.showsPresentables = sp
    }
    
    //init de ShowPresentable
    //forEach $0
    func mapShowtoSP (_ show: Show) -> ShowPresentable {
      
      return ShowPresentable(
                    id: show.id!,
                    name: show.name ?? "n/a",
                    type: show.type ?? "n/a",
                    language: show.language ?? "n/a",
                    genres: getStrFromArrOfStr(show.genres),
                    status: show.status ?? "n/a",
                    releaseYear: releaseYearFromPremiered(show.premiered),
                    rating: show.rating ?? "n/a",
                    image: show.image ?? "no image",
                    summary: show.summary ?? "n/a"
      )
        
    }
    
    func getStrFromArrOfStr(_ strArr: [String]?) -> String {

        var resultStr = ""

        guard let sa = strArr else {
            return "n/a"
         }

         for s in sa {
            
            if s != sa[0] {
                resultStr += ", \(s)"
            } else {
                resultStr += s
            }
            
         }

        return resultStr
    }
    
    func releaseYearFromPremiered(_ premiered: Date?) -> String {
        guard let date = premiered else {
            return "n/a"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)

        return yearString
    }
    
    func pushDetailVC(_ show: ShowPresentable, from view: UIViewController) {

        guard let navigation = view.navigationController else {
            return
        }

        let presenter = ShowDetailPresenter(show)

        let controller = ShowDetailViewController(presenter: presenter)

        navigation.pushViewController(controller, animated: true)

    }

}
