class ShowsBuilder {

    static func buildShows() -> ShowsViewController {
        
        let interactor = ShowsInteractor()
        
        let presenter = ShowsPresenter()
        
        let router = ShowsRouter()
        
        let controller = ShowsViewController()
        
        router.view = controller
        
        interactor.presenter = presenter
        
        controller.presenter = presenter
        
        presenter.view = controller
        
        presenter.interactor = interactor

        presenter.router = router
        
        return controller
        
    }
    
}
