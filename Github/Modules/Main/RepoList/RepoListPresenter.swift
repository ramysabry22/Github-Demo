

import Foundation
import UIKit
import NotificationCenter


enum RepoDetailsViewOptionsEnum {
    case RepoPage
    case OwnerPage
}

class RepoListPresenter: RepoListPresenterProtocol, RepoListInteractorOutputProtocol {
    
    weak var view: RepoListViewProtocol?
    private let interactor: RepoListInteractorInputProtocol?
    private let router: RepoListRouterProtocol?
    
    private var pageStartIndex: Int = 0
    private var isFinishedFetching: Bool = true
    private var selectedRepository: RealmRepoListViewModel!
    private var repositoriesArray = [RealmRepoListViewModel]()
    private var repositoriesSearchArray = [RealmRepoListViewModel]()
    private var isSearching: Bool = false
    private var allowLocalNotifications: Bool = false


    init(view: RepoListViewProtocol, interactor: RepoListInteractorInputProtocol, router: RepoListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
    
    
    
    
    
    // MARK:- Fetching Data
    //
    func fetchRepoData()
    {
        if pageStartIndex == 0 {
            view?.startLoading()
        }
        
        if isFinishedFetching
        {
            interactor?.fetchRepositories(startIndex: pageStartIndex, pageSize: 10)
            isFinishedFetching = false
        }
    }
    
    func paginateFetchingRepoData(currentIndex: Int)
    {
        if (currentIndex + 2) > repositoriesArray.count && isFinishedFetching == true
        {
            self.fetchRepoData()
        }
    }
    
    
    
    

    
    
    // MARK:- Fetching Data Result
    //
     func repositoriesLoadedSuccessfully(result: [RealmRepoListViewModel])
     {
        if result.count > 0
        {
            self.repositoriesArray.append(contentsOf: result)
            pageStartIndex += 1
            isFinishedFetching = true
            view?.reloadTableView()
            view?.stopRefreshControll()
            
            if allowLocalNotifications {
                view?.showLocalNotification(title: "New Repositories Here!", subTitle: "", body: "Check out new repositories now", timeInterval: 5)
            }
        }
     }
    
    
    
    
    
    
    
    // MARK:- Refreshing Data
    //
    func refreshData(showLocalNotification: Bool)
    {
        if isSearching == false
        {
            allowLocalNotifications = showLocalNotification
            isFinishedFetching = true
            pageStartIndex = 0
            repositoriesArray.removeAll()
            view?.reloadTableView()
            fetchRepoData()
            LocalStorageManager.delete(realmObjectType: RealmRepoListViewModel.self) { (done) in
                
            }
        }
        else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.view?.stopRefreshControll()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    // MARK:- Viewing Repo Details
    //
    func selectedRepoForDetails(section: Int, row: Int)
    {
        selectedRepository = repositoriesArray[row]
        view?.showTwoOptionsAlert(title: "Viewing Details?", message: "select repo details option", defualtButtonTitle: "Repo Page", cancelButtonTitle: "Owner Page", flag: 22)
    }
    
    func selectedRepoDetailsWithOptins(selected: RepoDetailsViewOptionsEnum)
    {
        switch selected
        {
        case .RepoPage:
            if let pageURL = URL(string: selectedRepository.htmlStringURL) {
                view?.openBrowserWithURL(url: pageURL)
            }
            else {
                view?.showAlert(title: LocalizableWords.Messeges.sorry, message: LocalizableWords.Messeges.invalidPageURL, buttonTitle: "OK", flag: 0)
            }
        case .OwnerPage:
            if let pageURL = URL(string: selectedRepository.owner!.htmlStringURL) {
                view?.openBrowserWithURL(url: pageURL)
            }
            else {
                view?.showAlert(title: LocalizableWords.Messeges.sorry, message: LocalizableWords.Messeges.invalidPageURL, buttonTitle: "OK", flag: 0)
            }
        }
    }
    
    
    
    
    
    
    // MARK:- Search
    //
    func search(text: String)
    {
        if text.count > 0
        {
            isSearching = true
            repositoriesSearchArray = repositoriesArray.filter { (repo) -> Bool in
                repo.name.localizedCaseInsensitiveContains(text)
            }
        }
        else
        {
            isSearching = false
        }
        view?.reloadTableView()
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK:- Cell Configurations
    //
    func getRowsCount() -> Int
    {
        if isSearching {
            return repositoriesSearchArray.count
        }
        else {
            return repositoriesArray.count
        }
    }
    
    func configureRepoListCell(cell: RepoListCell, sectionIndex: Int, rowIndex: Int)
    {
        var rowRepo: RealmRepoListViewModel!
        if isSearching
        {
            rowRepo = repositoriesSearchArray[rowIndex]
        }
        else
        {
            rowRepo = repositoriesArray[rowIndex]
        }
        
        cell.displayData(repoName: rowRepo.name, repoOwnerName: rowRepo.owner!.ownerName, repoDescription: rowRepo.repoDescription, profileImageStringURl: rowRepo.owner!.avatarImageStringURL, stringBackgroundColor: rowRepo.backgroundColor)
    }
    
    
    
    
    
    
    // MARK: Error Results
      //
      func serviceError(Error: String, statusCode: Int, flag: Int)
      {
         if pageStartIndex == 0
         {
             view?.showAlert(title: LocalizableWords.Messeges.sorry, message: Error, buttonTitle: "OK", flag: 0)
         }
      }
      
      
      
    
    
    
    
      
      // MARK:- Configurations
      func startLoading()
      {
          view?.startLoading()
      }
      
      func stopLoading()
      {
          view?.stopLoading()
      }
    
}
