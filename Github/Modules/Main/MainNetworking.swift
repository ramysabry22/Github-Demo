
import UIKit


class MainNetworking: BaseNetworking {
    
    
    static func fetchRepositories(startIndex: Int, pageSize: Int, completion: @escaping ([RepoListModel]?, Error?, Int) -> () )
    {
        let headers = getNormalHeaders()
        let stringURL = EndPointsRouter.loadRepositories.stringURL + "?page=" + "\(startIndex)" + "&per_page=" + "\(pageSize)"
        let url = URL(string: stringURL)

        GenericNetworking.requestJsonModel(URL: url!, Headers: headers, HTTPMethod: .get) { (result: Result<RepoListModel>, statusCode) in
            
            switch result
            {
            case .success(let result):
                completion(result,nil,statusCode)
                
            case .failure(let error):
                completion(nil,error,statusCode)
            }
        }
    }
    
    
}
