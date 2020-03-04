import UIKit

class ShowsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "showsTableViewCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    func setup(show: ShowPresentable) {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        name.text = show.name
        name.font = UIFont.boldSystemFont(ofSize: 20)
        rating.text = "Rating: \(show.rating)"

    }
        
}
