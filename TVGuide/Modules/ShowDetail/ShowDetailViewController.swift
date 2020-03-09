import UIKit

class ShowDetailViewController: UIViewController, NibLoadableView {
    
    static var nibName: String { "ShowDetailViewController" }
    
    var episodesBySeason = [(key: String, value: Array<EpisodePresentable>)]()
    
    var presenter: ShowDetailPresenter?

    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var episodeAmountLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        presenter?.viewDidLoad()
        configureTableView()
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
    
    func configureTableView() {
        let nib = UINib(nibName: "ShowDetailTableViewCell", bundle: nil)
        setTableViewDelegates()
        tableView.register(nib,
                           forCellReuseIdentifier: ShowDetailTableViewCell.reuseIdentifier)
    }
    
    func setTableViewDelegates() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
}

extension ShowDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return episodesBySeason.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.episodesBySeason[section]
        let header = "Season \(section.key)"
        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.episodesBySeason[section]
        return section.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowDetailTableViewCell.reuseIdentifier, for: indexPath) as! ShowDetailTableViewCell
        
        let section = self.episodesBySeason[indexPath.section]
        let episode = section.value[indexPath.row]
        cell.episodeTitle?.text = episode.name
        
        // Table height to its content's size
        tableHeightConstraint.constant = tableView.contentSize.height
        view.layoutSubviews()
        // Scroll height to it's content's size (stack view + table view)
        scrollView.contentSize = CGSize.init(width: self.view.frame.width, height: contentView.frame.height + tableView.contentSize.height)
        scrollView.layoutIfNeeded()

        cell.setup(episode: episode)
        
        return cell
        
    }


}

extension ShowDetailViewController: ShowDetailPresenterProtocol {

    func displayShow(show: ShowPresentable, summary: NSAttributedString) {
        setupShowInfo(show: show, summary: summary)
    }

    func displayEpisodes(episodes: [EpisodePresentable]) {
        setupEpisodeInfo(episodes: episodes)
        
        guard let episodesBySeason = presenter?.printEpisodesBySeason(episodes) else { return }
        
        self.episodesBySeason = episodesBySeason
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
