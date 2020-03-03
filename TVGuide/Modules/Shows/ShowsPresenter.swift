import Foundation
import UIKit

protocol ShowsPresenterToShowsVC: class {

    func displayShows()

}

class ShowsPresenter {

    private let interactor = ShowsInteractor()
    weak var view: ShowsPresenterToShowsVC?
    var showsPresentables = [ShowPresentable]()

    init() {
        
    }
    
    func viewDidLoad() {
        interactor.presenter = self
    }
    
    func getShows() {
        
        interactor.fetchShows()
        
    }
    
    func getShowsPresentables() -> [ShowPresentable] {
        
        return self.showsPresentables
        
    }
    
    func getShowPresentableFromPositionInArr(_ pos: Int) -> ShowPresentable {
        
        return showsPresentables[pos]
        
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

extension ShowsPresenter: ShowsInteractorToShowsPresenter {
    
    func didRespond(shows: [Show]) {
        ShowstoSPresentables(shows: shows)
        view?.displayShows()
    }
    
}
