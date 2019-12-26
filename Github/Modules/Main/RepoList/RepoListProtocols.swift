
import Foundation


protocol RepoListViewProtocol: class
{
    var presenter: RepoListPresenterProtocol? { get set }
    func showTwoOptionsAlert(title: String, message: String, defualtButtonTitle: String, cancelButtonTitle: String, flag: Int)
    func showAlert(title: String, message: String, buttonTitle: String, flag: Int)
    func startLoading()
    func stopLoading()
    func reloadTableView()
    func openBrowserWithURL(url: URL)
    func stopRefreshControll()
    func showLocalNotification(title: String, subTitle: String, body: String, timeInterval: TimeInterval)
}
protocol RepoListPresenterProtocol: class
{
    var view: RepoListViewProtocol? { get set }
    func fetchRepoData()
    func paginateFetchingRepoData(currentIndex: Int)
    func getRowsCount() -> Int
    func configureRepoListCell(cell: RepoListCell, sectionIndex: Int, rowIndex: Int)
    func selectedRepoForDetails(section: Int, row: Int)
    func selectedRepoDetailsWithOptins(selected: RepoDetailsViewOptionsEnum)
    func search(text: String)
    func refreshData(showLocalNotification: Bool)
}



protocol RepoListRouterProtocol
{
    
}



protocol RepoListInteractorInputProtocol
{
    var presenter: RepoListInteractorOutputProtocol? { get set }
    func fetchRepositories( startIndex: Int, pageSize: Int)
}
protocol RepoListInteractorOutputProtocol: class
{
    func startLoading()
    func stopLoading()
    func serviceError(Error: String, statusCode: Int, flag: Int)
    func repositoriesLoadedSuccessfully(result: [RealmRepoListViewModel])
}



// MARK:- Cells Protocols
protocol RepoListCellView
{
    func displayData(repoName: String, repoOwnerName: String, repoDescription: String, profileImageStringURl: String?, stringBackgroundColor: String)
}
