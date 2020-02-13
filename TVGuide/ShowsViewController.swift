import UIKit

class ShowsViewController: UIViewController {
    
    var shows: ShowList?
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        let networkManager = NetworkManager()
        networkManager.getShows() { (showsList) in
            
            guard let shows = showsList else {
                return
            }
            self.shows = shows
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 154
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "ShowsTableViewCell", bundle: nil)
        setTableViewDelegates()
        tableView.rowHeight = 150
        tableView.register(nib,
                     forCellReuseIdentifier: "showsTableViewCell")
    }
    
    func setTableViewDelegates() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }

}

extension ShowsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let shows = shows else {
           return 0
        }
        return shows.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "showsTableViewCell", for: indexPath) as! ShowsTableViewCell
        
        if let show = shows?[indexPath.row] {
            cell.setup(show: show)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ShowDetailViewController(nibName: "ShowDetailViewController", bundle: nil)
        vc.show = shows?[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
