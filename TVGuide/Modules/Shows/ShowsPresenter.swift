import Foundation
import UIKit

protocol ShowsPresenterToShowsVC: class {

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
        
        shows.forEach({
            sp.append(ShowPresentable.init($0))
        })
        
        self.showsPresentables = sp
        
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
