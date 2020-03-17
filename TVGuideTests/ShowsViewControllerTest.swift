//
//  ShowsViewControllerTest.swift
//  TVGuide
//
//  Created by Laura Daniela Krayacich on 16/03/2020.
//  Copyright © 2020 Laura Daniela Krayacich. All rights reserved.
//

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

class NetworkManagerMock: NetworkManager {
    
    override func getShows(completion: @escaping ([ShowDTO]?) -> Void) {
        
        let showDTO = ShowDTO(id: 1, url: "saraza", name: "saraza", type: "saraza", language: "saraza", genres: ["saraza"], status: "saraza", runtime: 1, premiered: nil, officialSite: "saraza", schedule: nil, rating: nil, weight: 1, network: nil, webChannel: nil, externals: nil, image: nil, summary: "saraza", updated: 1, links: nil)
        
        var showDTOArray = [ShowDTO]()
        showDTOArray.append(showDTO)
        showDTOArray.append(showDTO)
        showDTOArray.append(showDTO)
        showDTOArray.append(showDTO)
        showDTOArray.append(showDTO)
        
        completion(showDTOArray)
        
    }
    
    override func searchShows(search: String?, completion: @escaping ([ShowSearchResultDTO]?) -> Void) {
        
        let showDTO = ShowDTO(id: 1, url: "saraza", name: "saraza", type: "saraza", language: "saraza", genres: ["saraza"], status: "saraza", runtime: 1, premiered: nil, officialSite: "saraza", schedule: nil, rating: nil, weight: 1, network: nil, webChannel: nil, externals: nil, image: nil, summary: "saraza", updated: 1, links: nil)
        
        let showSearchResultDTO = ShowSearchResultDTO(score: 0.0, show: showDTO)
        
        var showSearchResultDTOArray = [ShowSearchResultDTO]()
        showSearchResultDTOArray.append(showSearchResultDTO)
        showSearchResultDTOArray.append(showSearchResultDTO)
        showSearchResultDTOArray.append(showSearchResultDTO)
        
        completion(showSearchResultDTOArray)
    }
}

class ShowsInteractorMock: ShowsInteractor {
    
    override func fetchShows() {
        
        var shows = [Show]()
        
        let networkManager = NetworkManagerMock()
        networkManager.getShows() { [weak self] (showsList) in
            
            guard let showListDTO = showsList else {
                return
            }
            
            for showDTO in showListDTO {
                shows.append(ShowDTOMapper.map(showDTO))
            }
            
            self?.presenter?.didRespond(shows: shows)
            
        }
    }
    
    override func searchShows(_ searchStr: String) {
        
        var shows = [Show]()
        
        let networkManager = NetworkManagerMock()
        networkManager.searchShows(search: searchStr) { [weak self] (showsList) in
            
            guard let showSearchResultListDTO = showsList else {
                return
            }
            
            showSearchResultListDTO.forEach({
                if let showDTO = $0.show {
                   shows.append(ShowDTOMapper.map(showDTO))
                }
            })

            self?.presenter?.didRespond(shows: shows)
            
        }
    }
}

class ShowsRouterMock: ShowsRouter {
    var presenterVC: UIViewController?
    
    override func routeToShowDetail(show: ShowPresentable) {

        let showDetail = ShowDetailBuilder.buildShowDetail(show: show)

        presenterVC = showDetail
        
    }
}
