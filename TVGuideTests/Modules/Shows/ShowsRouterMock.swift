import Foundation
import UIKit

class ShowsRouterMock: ShowsRouter {
    var presenterVC: UIViewController?
    
    override func routeToShowDetail(show: ShowPresentable) {

        let showDetail = ShowDetailBuilder.buildShowDetail(show: show)

        presenterVC = showDetail
        
    }
}
