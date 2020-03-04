import UIKit

class ShowDetailViewController: UIViewController, NibLoadableView {
    
    static var nibName: String { "ShowDetailViewController" }
    
    var presenter: ShowDetailPresenter?

    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var episodeAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        presenter?.viewDidLoad()
    }
    
    func setupShowInfo(show: ShowPresentable, summary: NSAttributedString) {
        showTitle.text = show.name
        if let img = show.image {
            showImage.downloadImage(from: img)
        }
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
