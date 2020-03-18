import Foundation
import UIKit
@testable import TVGuide

class ShowsRouterMock: ShowsRouter {
    var presenterVC: UIViewController?
    
    override func routeToShowDetail(show: ShowPresentable) {

        let showDetail = ShowDetailBuilder.buildShowDetail(show: show)

        presenterVC = showDetail
        
    }
}
