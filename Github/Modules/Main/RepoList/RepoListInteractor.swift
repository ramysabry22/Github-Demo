import Foundation
import RealmSwift


class RepoListInteractor: RepoListInteractorInputProtocol{
    
    weak var presenter: RepoListInteractorOutputProtocol?
    

    func fetchRepositories(startIndex: Int, pageSize: Int)
    {
        MainNetworking.fetchRepositories(startIndex: startIndex, pageSize: pageSize) { (result, error, statusCode) in
            
            self.presenter?.stopLoading()
            
            if result != nil
            {
                var repoResultArray = [RealmRepoListViewModel]()
                result!.forEach { (repo) in
                    repoResultArray.append(RealmRepoListViewModel(RepoModel: repo))
                }
                LocalStorageManager.insert(realmObject: repoResultArray) { (finished) in
                    
                }
                self.presenter?.repositoriesLoadedSuccessfully(result: repoResultArray)
            }
            else
            {
                LocalStorageManager.select(realmObjectType: RealmRepoListViewModel.self, realmObject: Object() )
                { (data) in
                    
                    if data != nil
                    {
                        self.presenter?.repositoriesLoadedSuccessfully(result: data as! [RealmRepoListViewModel])
                    }
                    else
                    {
                        if error != nil
                        {
                            self.presenter?.serviceError(Error: error?.localizedDescription ?? LocalizableWords.Messeges.unExpected, statusCode: statusCode, flag: 0)
                        }
                        else
                        {
                            self.presenter?.serviceError(Error: LocalizableWords.Messeges.unExpected, statusCode: statusCode, flag: 0)
                        }
                    }
                    
                }
            }
        }
    }
  
    
    
}
