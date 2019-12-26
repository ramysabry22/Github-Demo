
import Foundation

enum EndPointsRouter {
    
    case loadRepositories
   
    
    
    
    // MARK:- URL
    /**********************************************/
    private var devScheme: String
    {
        return "https://"
    }
    private var devHost: String
    {
        return "api.github.com/"
    }
    
    
    private var productionScheme: String
    {
        return ""
    }
    private var productionHost: String
    {
        return ""
    }
    
    private var path: String
    {
        switch self
        {
        case .loadRepositories:
            return "users/square/repos"
        }
    }
    
    var url: URL
    {
        let stringURL = devScheme + devHost + path
        return URL(string: stringURL)!
    }
    
    var stringURL: String
    {
        return devScheme + devHost + path
    }
    
    
    var stringBaseURL: String
    {
        return devScheme + devHost
    }
    
}



