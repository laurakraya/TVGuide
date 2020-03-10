import UIKit

class ShowsViewController: UIViewController {
    
    var presenter: ShowsPresenter?
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.getShows()
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
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Shows"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

}

extension ShowsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return presenter?.getShowsPresentables().count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowsTableViewCell.reuseIdentifier, for: indexPath) as! ShowsTableViewCell
        
        guard let show = presenter?.getShowPresentableFromPositionInArr(indexPath.row) else { return cell }
        
        cell.setup(show: show)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        presenter?.pushShowDetail(indexPath.row)
        
    }

}

extension ShowsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if isFiltering {
            presenter?.searchShows(query: searchBar.text!)
        } else {
            presenter?.getShows()
        }
                
    }
    
}

extension ShowsViewController: ShowsPresenterToShowsVC {

    func displayShows() {

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
