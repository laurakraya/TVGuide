import Foundation
import UIKit

protocol ShowsPresenterToShowsVC: UIViewController {

    func displayShows(_ shows: [Show])

}

class ShowsPresenter {

    weak var view: ShowsPresenterToShowsVC?
    var shows = [Show]()

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

            self.view?.displayShows(self.shows)
        }
    }
    
    func pushDetailVC(_ show: Show, from view: UIViewController) {

        guard let navigation = view.navigationController else {
            return
        }

        let presenter = ShowDetailPresenter(show)

        let controller = ShowDetailViewController(presenter: presenter)

        navigation.pushViewController(controller, animated: true)

    }

}
