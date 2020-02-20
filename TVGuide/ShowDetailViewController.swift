import UIKit

class ShowDetailViewController: UIViewController, NibLoadableView {
    
    static var nibName: String { "ShowDetailViewController" }

    
    var show: Show?
    var episodes = [Episode]()

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
        fetchEpisodes()
        setup()
    }
    
    func fetchEpisodes() {
        let networkManager = NetworkManager()
        networkManager.getEpisodeList(id: show?.id) { (episodesList) in
            guard let episodesListDTO = episodesList else {
                return
            }
            
            for episodeDTO in episodesListDTO {
                let episode = EpisodeDTOMapper.map(episodeDTO)
                self.episodes.append(episode)
            }
            
            self.episodeAmountLabel.text = "\(self.episodes.count)"
        }
    }
    
    func setup() {
        
        guard let show = self.show else {
            return
        }
        
        showTitle.text = show.name
        
        let url = URL(string: show.image ?? "no image")
        showImage.downloadImage(from: url!)

        setShowDescription(show: show)
        typeLabel.text = show.type ?? "n/a"
        statusLabel.text = show.status ?? "n/a"
        genresLabel.text = getGenresStrFromArr(show: show)
        releaseYear.text = releaseYearFromPremiered(show: show)
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
