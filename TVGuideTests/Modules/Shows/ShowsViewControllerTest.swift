import XCTest
@testable import TVGuide

class ShowsViewControllerTest: XCTestCase {
    let interactor = ShowsInteractor()
    let presenter = ShowsPresenter()
    let router = ShowsRouter()
    let controller = ShowsViewController()

    override func setUp() {
        interactor.presenter = presenter
        router.view = controller
        presenter.router = router
        presenter.interactor = interactor
        controller.presenter = presenter
        presenter.view = controller
    }
    
    //qué pasa cuando se carga la vista
    func testViewDisplaysDataReceivedFromBackEndCorrectly() {
        //Arrange
        let mockInteractor = ShowsInteractorMock()
        presenter.interactor = mockInteractor
        mockInteractor.presenter = presenter
        controller.loadViewIfNeeded()
        
        //Act
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          expectation.fulfill()
          //assert
            XCTAssertTrue(self.controller.presenter?.getShowsPresentables().count == 5)
        }
        wait(for: [expectation], timeout: 5)
        
    }
    
    //qué pasa al seleccionar una celda
    func testDidSelectRowIsPushingToCorrectViewController() {
        //Arrange
        let mockInteractor = ShowsInteractorMock()
        let mockRouter = ShowsRouterMock()
        presenter.router = mockRouter
        mockRouter.view =  controller
        presenter.interactor = mockInteractor
        mockInteractor.presenter = presenter
        controller.loadViewIfNeeded()
        
        //Act
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          expectation.fulfill()
            self.controller.tableView.delegate?.tableView?(self.controller.tableView, didSelectRowAt: IndexPath(row: 3, section: 0))
          //assert
            XCTAssertTrue(mockRouter.presenterVC is ShowDetailViewController)
        }
        wait(for: [expectation], timeout: 5)
    }
    
    //qué pasa al utilizar la searchbar con input
    func testSearchBringsTheCorrectAmountOfShowsWhenSearchbarInputIsNotEmpty() {
        //Arrange
        let mockInteractor = ShowsInteractorMock()
        presenter.interactor = mockInteractor
        mockInteractor.presenter = presenter
        controller.loadViewIfNeeded()
        
        //Act
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          expectation.fulfill()
            self.controller.searchBar.text = "Dome"
            self.controller.searchBar.delegate?.searchBar?(self.controller.searchBar, textDidChange: "Dome")
            //assert
            XCTAssertTrue(!self.controller.isSearchBarEmpty)
            
            XCTAssertTrue(self.controller.presenter?.getShowsPresentables().count == 3)
        }
        wait(for: [expectation], timeout: 5)
    }
    
    //qué pasa al utilizar la searchbar con input vacío
    func testSearchFetchesAllShowsWhenSearchbarInputIsEmpty() {
        //Arrange
        let mockInteractor = ShowsInteractorMock()
        presenter.interactor = mockInteractor
        mockInteractor.presenter = presenter
        controller.loadViewIfNeeded()
        
        //Act
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          expectation.fulfill()
            self.controller.searchBar.text = ""
            self.controller.searchBar.delegate?.searchBar?(self.controller.searchBar, textDidChange: "")
            //assert
            XCTAssertTrue(self.controller.isSearchBarEmpty)
            
            XCTAssertTrue(self.controller.presenter?.getShowsPresentables().count == 5)
        }
        wait(for: [expectation], timeout: 5)
    }
    

}
