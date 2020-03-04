class ShowDetailBuilder {

    static func buildShowDetail(show: ShowPresentable) -> ShowDetailViewController {
        
        let interactor = ShowDetailInteractor()
        
        let presenter = ShowDetailPresenter(show)
        
        let router = ShowDetailRouter()
        
        let controller = ShowDetailViewController()
        
        interactor.presenter = presenter
        
        router.view = controller
        
        presenter.router = router
        
        presenter.interactor = interactor
        
        controller.presenter = presenter
        
        presenter.view = controller
        
        return controller
        
    }
    
}
