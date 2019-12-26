
import UIKit
import RealmSwift


class BaseNetworking: NSObject {
    
    
    
    // MARK:-
    class func getAccessToken() -> String
    {
        let token = SharedKeychain.get(key: LocalizableWords.privateMesseges.accessToken)
        return "Bearer" + " " + (token ?? "")
    }
    
    class func getRefreshToken() -> String
    {
        let token = SharedKeychain.get(key: LocalizableWords.privateMesseges.refreshToken)
        return "Bearer" + " " + (token ?? "")
    }
    
    
    class func getAuthorizedHeaders() -> [String: String]
    {
        let accessToken = getAccessToken()
        let headers: [String: String] = [ "Content-Type": "application/json", "authorization": accessToken  ]
        return headers
    }
    
    class func getNormalHeaders() -> [String: String]
    {
        let headers: [String: String] = [ "Content-Type": "application/json"  ]
        return headers
    }
    
    
    
   
    
    
    
}
