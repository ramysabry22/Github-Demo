

import UIKit

class RepoListViewController: BaseViewController, RepoListViewProtocol {
    
    @IBOutlet weak var repoTableView: UITableView!
    
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)
    lazy var refreshControl = UIRefreshControl()
    var presenter: RepoListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.fetchRepoData()
    }
    
    
    
    
    
   func openBrowserWithURL(url: URL)
   {
       UIApplication.shared.open(url, options: [:], completionHandler: nil)
   }
    
   func stopRefreshControll()
   {
        refreshControl.endRefreshing()
   }
    
   func reloadTableView()
   {
       repoTableView.reloadData()
   }
    
   func showAlert(title: String, message: String, buttonTitle: String, flag: Int)
   {
       showOneButtonAlert(title: title, message: message, buttonTitle: buttonTitle)
       {
           
       }
   }
    
   func showTwoOptionsAlert(title: String, message: String, defualtButtonTitle: String, cancelButtonTitle: String, flag: Int)
   {
        showTwoButtonAlert(title: title, message: message, cancelButtonTitle: cancelButtonTitle, defaultButtonTitle: defualtButtonTitle) { (defualtTapped) in
            
            if defualtTapped {
                self.presenter?.selectedRepoDetailsWithOptins(selected: .RepoPage)
            }
            else {
                self.presenter?.selectedRepoDetailsWithOptins(selected: .OwnerPage)
            }
        }
    }
    
   func startLoading()
   {
       showLoadingIndicator()
   }
   
   func stopLoading()
   {
       hideLoadingIndicator()
   }
    
   func showLocalNotification(title: String, subTitle: String, body: String, timeInterval: TimeInterval)
   {
        scheduleLocalNotification(title: title, subTitle: subTitle, body: body, timeInterval: timeInterval)
   }
    
    
    
    
    
    @objc func refresh(sender: AnyObject)
    {
        presenter?.refreshData(showLocalNotification: false)
    }
    
    private func setupViews()
    {
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.prefetchDataSource = self
        repoTableView.allowsSelection = false
        repoTableView.tableFooterView = UIView()
        repoTableView.register(UINib(nibName: GithubViews.Cells.RepoListCell, bundle: nil), forCellReuseIdentifier: GithubViews.Cells.RepoListCell)
        
        navigationController?.title = "Github Repositories"
        navigationController?.navigationBar.prefersLargeTitles = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Refresh Repositories")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        repoTableView.addSubview(refreshControl)
    }
    
}



extension RepoListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2)
        {
            self.presenter?.search(text: searchText)
        }
    }

    
    
}


