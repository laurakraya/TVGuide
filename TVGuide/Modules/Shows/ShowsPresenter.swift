import Foundation
import UIKit

protocol ShowsPresenterToShowsVC: class {

    func displayShows()

}

class ShowsPresenter {

    weak var view: ShowsPresenterToShowsVC?
    
    var interactor: ShowsInteractor?
    var router: ShowsRouter?
    
    var showsPresentables = [ShowPresentable]()
    
    func getShows() {
        
        interactor?.fetchShows()
        
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
    
    func pushShowDetail(_ pos: Int) {
        
        router?.routeToShowDetail(show: showsPresentables[pos])

    }

}

extension ShowsPresenter: ShowsInteractorToShowsPresenter {
    
    func didRespond(shows: [Show]) {
        ShowstoSPresentables(shows: shows)
        view?.displayShows()
    }
    
}
