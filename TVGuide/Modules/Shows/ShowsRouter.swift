import UIKit

class ShowsRouter {
    
    static func start() -> UIViewController {
        
        let showsPresenter = ShowsPresenter(router: ShowsRouter())
        
        return ShowsViewController(presenter: showsPresenter)
        
    }
    
    func routeToShowDetail(show: ShowPresentable, from view: UIViewController) {
        
        guard let navigation = view.navigationController else {
            return
        }

        let showDetail = ShowDetailRouter.start(show: show)

        navigation.pushViewController(showDetail, animated: true)
        
    }
}
