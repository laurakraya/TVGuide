import UIKit

class ShowDetailViewController: UIViewController, NibLoadableView {
    
    static var nibName: String { "ShowDetailViewController" }
    
    private let presenter: ShowDetailPresenter

    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var episodeAmountLabel: UILabel!
    
    init(presenter: ShowDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: "ShowDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    func setupShowInfo(show: ShowPresentable, summary: NSAttributedString) {
        showTitle.text = show.name
        showImage.downloadImage(from: show.image)
        showDescription.attributedText = summary
        showDescription.font = UIFont.italicSystemFont(ofSize: 16.0)
        showDescription.textColor = UIColor.white
        typeLabel.text = show.type
        statusLabel.text = show.status
        genresLabel.text = show.genres
        releaseYear.text = show.releaseYear
    }
    
    func setupEpisodeInfo(episodes: [EpisodePresentable]) {
        episodeAmountLabel.text = "\(episodes.count)"
    }
    
}

extension ShowDetailViewController: ShowDetailPresenterProtocol {

    func displayShow(show: ShowPresentable, summary: NSAttributedString) {
        setupShowInfo(show: show, summary: summary)
    }

    func displayEpisodes(episodes: [EpisodePresentable]) {
        setupEpisodeInfo(episodes: episodes)
    }

}
