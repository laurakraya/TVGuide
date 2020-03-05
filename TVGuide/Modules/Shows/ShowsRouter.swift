import UIKit

class ShowsRouter {
    
    weak var view: UIViewController?
    
    func routeToShowDetail(show: ShowPresentable) {
        
        guard let navigation = view?.navigationController else { return }

        let showDetail = ShowDetailBuilder.buildShowDetail(show: show)

        navigation.pushViewController(showDetail, animated: true)
        
    }
}
