import UIKit

class ShowDetailViewController: UIViewController, NibLoadableView {
    
    static var nibName: String { "ShowDetailViewController" }

    
    var show: Show?
    var episodes = [Episode]()
    
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
    
    func setupShowInfo(show: Show) {
        showTitle.text = show.name
        let url = URL(string: show.image ?? "no image")
        showImage.downloadImage(from: url!)
        setShowDescription(show: show)
        typeLabel.text = show.type
        statusLabel.text = show.status
        genresLabel.text = getGenresStrFromArr(show: show)
        releaseYear.text = releaseYearFromPremiered(show: show)
    }
    
    func setupEpisodeInfo(episodes: [Episode]) {
        episodeAmountLabel.text = "\(episodes.count)"
    }
    
    func getGenresStrFromArr(show: Show) -> String {

        var genresStr = ""

        guard let genres = show.genres else {
            return "n/a"
         }

         for g in genres {
            if g != genres[0] {
                genresStr += ", \(g)"
            } else {
                genresStr += g
            }
            
         }

        return genresStr
    }
    
    func setShowDescription(show: Show) {
        let data = Data(show.summary?.utf8 ?? "n/a".utf8)
        if let attributedString = try? NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            showDescription.attributedText = attributedString
            showDescription.font = UIFont.italicSystemFont(ofSize: 16.0)
            showDescription.textColor = UIColor.white
        }
    }
    
    func releaseYearFromPremiered(show: Show) -> String {
        guard let date = show.premiered else {
            return "n/a"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)

        return yearString
    }

}

extension ShowDetailViewController: ShowDetailPresenterProtocol {

    func displayShow(show: Show) {
        setupShowInfo(show: show)
    }

    func displayEpisodes(episodes: [Episode]) {
        setupEpisodeInfo(episodes: episodes)
    }

}
