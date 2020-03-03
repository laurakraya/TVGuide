class ShowDetailBuilder {

    static func buildShowDetail(show: ShowPresentable) -> ShowDetailViewController {
        
        let presenter = ShowDetailPresenter(show)
        
        let router = ShowDetailRouter()
        
        let controller = ShowDetailViewController()
        
        router.view = controller
        
        presenter.router = router
        
        controller.presenter = presenter
        
        presenter.view = controller
        
        return controller
        
    }
    
}
