import UIKit

class ShowsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "showsTableViewCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    func setup(show: Show) {
        
        if let showName = show.name {
            name.text = "\(showName) (\(releaseYearFromPremiered(show: show)))"
        } else {
            name.text = "n/a"
        }
        name.font = UIFont.boldSystemFont(ofSize: 20)
        
        if let showRating = show.rating {
           rating.text = "Rating: \(showRating)"
        } else {
            rating.text = "Rating: n/a"
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
