class ShowsBuilder {

    static func buildShows() -> ShowsViewController {
        
        let presenter = ShowsPresenter()
        
        let router = ShowsRouter()
        
        let controller = ShowsViewController()
        
        router.view = controller
        
        presenter.router = router
        
        controller.presenter = presenter
        
        presenter.view = controller
        
        return controller
        
    }
    
}
