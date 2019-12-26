
import UIKit


class GenericNetworking: NSObject {
    
    class func requestJsonModel<U: Codable>(URL: URL, Headers: [String: String]?, HTTPMethod: HTTPMethod,_ handler: @escaping( _ result: Result<U>, _ StatusCode: Int) -> ()) {
        
        var statusCode: Int = 0
        
        let backgroundTaskID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        let session: URLSession = URLSession(configuration: .default)
        var request: URLRequest = URLRequest(url: URL)
        request.httpBody = nil
        request.httpMethod = HTTPMethod.rawValue
        
        if let headers = Headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        session.dataTask(with: request) {(data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            if let error = error {
                DispatchQueue.main.async {
                    handler(.failure(error),statusCode)
                    UIApplication.shared.endBackgroundTask(backgroundTaskID)
                }
            }
            
            if let data = data {
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                
                    print("Headers: ", Headers ?? "")
                    print("Parameters: ", "nil")
                    print("URL: ", URL)
                    print("HTTP Method: ", HTTPMethod.rawValue)
                    print("**************** Response *************** \n")
                    print(jsonResponse)
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonResponse)
                    let jsonModel = try JSONDecoder().decode([U].self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        handler(.success(jsonModel),statusCode)
                        return UIApplication.shared.endBackgroundTask(backgroundTaskID)
                    }
                    
                }catch {
                    DispatchQueue.main.async {
                        handler(.failure(error),statusCode)
                        UIApplication.shared.endBackgroundTask(backgroundTaskID)
                    }
                }
            }
        }.resume()
    }
    
    
    
    
}
