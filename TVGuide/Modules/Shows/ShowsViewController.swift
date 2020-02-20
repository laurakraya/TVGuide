import UIKit

class ShowsViewController: UIViewController {
    
    var shows = [Show]()
    private let presenter: ShowsPresenter
    @IBOutlet var tableView: UITableView!
    
    init(presenter: ShowsPresenter) {
        self.presenter = presenter
        super.init(nibName: "ShowsViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getShows()
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
                           forCellReuseIdentifier: ShowsTableViewCell.reuseIdentifier)
    }
    
    func setTableViewDelegates() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }

}

extension ShowsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return shows.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowsTableViewCell.reuseIdentifier, for: indexPath) as! ShowsTableViewCell
        
        cell.setup(show: shows[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let show = shows[indexPath.row]

        presenter.pushDetailVC(show, from: self)
        
    }

}

extension ShowsViewController: ShowsPresenterToShowsVC {

    func displayShows(_ shows: [Show]) {

        self.shows = shows

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
