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
        name.text = "\(show.name) (\(releaseYearFromPremiered(show: show)))"
        name.font = UIFont.boldSystemFont(ofSize: 20)
        let ratingStr = "\(show.rating)"
        let start = ratingStr.index(ratingStr.startIndex, offsetBy: 25)
        let end = ratingStr.index(ratingStr.endIndex, offsetBy: -2)
        let range = start..<end

        let mySubstring = ratingStr[range]
        
        rating.text = "Rating: \(mySubstring)"
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
