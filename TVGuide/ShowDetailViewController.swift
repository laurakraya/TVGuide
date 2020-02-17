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
        networkManager.getEpisodeList(id: show?.id) { (showsList) in
            guard let episodes = showsList else {
                return
            }
            self.episodes = episodes
            self.episodeAmountLabel.text = "\(self.episodes.count)"
        }
    }
    
    func setup() {
        
        guard let show = self.show else {
            return
        }
        
        showTitle.text = show.name
        
        let url = URL(string: show.image.original)
        showImage.downloadImage(from: url!)
        
        
        setShowDescription(show: show)
        typeLabel.text = show.type.rawValue
        statusLabel.text = show.status.rawValue
        setGenreLabel(show: show)
        releaseYear.text = releaseYearFromPremiered(show: show)
    }
    
    func setShowDescription(show: Show) {
        let data = Data(show.summary.utf8)
        if let attributedString = try? NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            showDescription.attributedText = attributedString
            showDescription.font = UIFont.italicSystemFont(ofSize: 16.0)
            showDescription.textColor = UIColor.white
        }
    }
    
    func setGenreLabel(show: Show) {
        let genres = show.genres
        var genresStr = ""
        for genre in genres {
            if genre == genres[0] {
                genresStr += "\(genre.rawValue)"
            } else {
                genresStr += ", \(genre.rawValue)"
            }
        }
        genresLabel.text = genresStr
    }
    
    func releaseYearFromPremiered(show: Show) -> String {
        let str = "\(show.premiered)"
        let start = str.index(str.startIndex, offsetBy: 0)
        let end = str.index(str.endIndex, offsetBy: -6)
        let range = start..<end
        let releaseYear = String(str[range])

        return releaseYear
    }

}

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
