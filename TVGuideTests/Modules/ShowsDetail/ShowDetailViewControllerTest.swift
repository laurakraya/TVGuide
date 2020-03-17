import XCTest
@testable import TVGuide

class ShowDetailViewControllerTest: XCTestCase {
    let show = Show(id: 1, name: "El Show", type: "Scripted", language: "tagalog", genres: ["drama", "comedia", "terror"], status: "Ongoing", premiered: nil, rating: "10", image: nil, summary: "<p>Un show para conquistarlos a todos</p>")
    var showPresentable: ShowPresentable?
    let interactor = ShowDetailInteractor()
    var presenter: ShowDetailPresenter?
    let router = ShowDetailRouter()
    let controller = ShowDetailViewController()

    override func setUp() {
        showPresentable = ShowPresentable(show)
        presenter = ShowDetailPresenter(showPresentable!)
        interactor.presenter = presenter
        router.view = controller
        presenter?.router = router
        presenter?.interactor = interactor
        controller.presenter = presenter
        presenter?.view = controller
    }

    func testViewDisplaysEpisodesReceivedFromBackEndCorrectly() {
        //Arrange
        let mockInteractor = ShowDetailInteractorMock()
        presenter?.interactor = mockInteractor
        mockInteractor.presenter = presenter
        controller.loadViewIfNeeded()
        
        //Act
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          expectation.fulfill()
          //assert
            XCTAssertTrue(self.controller.presenter?.show?.episodes?.numberOfSections == 2)
            XCTAssertTrue(self.controller.presenter?.show?.episodes?.numberOfEpisodes() == "6")
        }
        wait(for: [expectation], timeout: 5)
        
    }
    
    //labels
    func testViewLabelsDisplayCorrectText() {
        //Arrange
        //Act

        //Assert
        XCTAssertNil(self.controller.showDescription)
        //XCTAssertTrue(self.controller.showDescription.text == "Un show para conquistarlos a todos")
        //print(controller.showDescription.text)

    }
    
    func testTesting() {
        //Arrange
        let mockInteractor = ShowDetailInteractorMock()
        presenter?.interactor = mockInteractor
        mockInteractor.presenter = presenter
        controller.loadViewIfNeeded()
        
        //Act
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          expectation.fulfill()
          //assert
            XCTAssertTrue(self.controller.showTitle.text == "El Show")
            XCTAssertTrue(self.controller.typeLabel.text == "Scripted")
            XCTAssertTrue(self.controller.statusLabel.text == "Ongoing")
            XCTAssertTrue(self.controller.genresLabel.text == "drama, comedia, terror")
            XCTAssertTrue(self.controller.releaseYear.text == "n/a")
            XCTAssertTrue(self.controller.episodeAmountLabel.text == "6")
            XCTAssertTrue(self.controller.showDescription.text == "Un show para conquistarlos a todos\n")
        }
        wait(for: [expectation], timeout: 5)
        
        
    }
    
}
