import UIKit

class ShowsViewController: UIViewController {
    
    var presenter: ShowsPresenter?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
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
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Shows"
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.textColor = .systemIndigo
        searchBar.searchTextField.leftView?.tintColor = .systemIndigo
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

extension ShowsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !isSearchBarEmpty {
            presenter?.searchShows(query: searchText)
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
