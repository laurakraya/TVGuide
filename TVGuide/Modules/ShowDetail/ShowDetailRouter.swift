import UIKit

class ShowDetailRouter {
    
    static func start(show: ShowPresentable) -> UIViewController {
        
        let presenter = ShowDetailPresenter(show, router: ShowDetailRouter())
        
        let controller = ShowDetailViewController(presenter: presenter)
        
        return controller
        
    }
    
}
