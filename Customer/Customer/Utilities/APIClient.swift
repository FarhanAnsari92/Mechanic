//
//  APIClient.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 16/10/2021.
//

import Foundation
import Alamofire

struct BaseURL {
    static let staging: URL = URL(string: "https://aspenweather.net/motox-services/api/")!
}

enum API: String {
    case registration = "register"
    case login = "login"
    case cities = "cities"
    case brands = "brands"
    case model = "vehicle-models"
    case service = "services"
}

enum APIVersion: String {
    case v1 = "v1"
//    case v2 = "v2"
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

class APIClient {
    
    class func callApi(
        api: API,
        apiVersion: APIVersion = .v1,
        parameters: [String:String]? = nil,
        method: HTTPMethod,
        view: UIView? = nil,
        success: @escaping ([String:Any]?) -> Void) {
        
        let path = apiVersion.rawValue + "/" + api.rawValue
        let url: URL = URL(string: path, relativeTo: BaseURL.staging)!
        
        if let _ = view {
            view?.showHud()
        }
        
        print("URL - ", url.absoluteURL)
        
        var urlComponent = URLComponents(string: url.absoluteString)
        if let param = parameters {
            var querryItem = [URLQueryItem]()
            param.forEach { (key, value) in
                querryItem.append(URLQueryItem(name: key, value: value))
            }
            
            urlComponent?.queryItems = querryItem
        }
        
        var urlRequest = URLRequest(url: (urlComponent?.url)!)
        urlRequest.httpMethod = method.rawValue
        if let user = User.shared.getUser(),
           let accessToken = user.accessToken {
            let headerValue = "Bearer \(accessToken)"
            urlRequest.setValue(headerValue, forHTTPHeaderField: "Authorization")
        }
        
        let request = Alamofire.request(urlRequest)
        let responseHandler: ((DataResponse<Any>) -> Void) = { reponse in
            if let _ = view {
                view?.hideHud()
            }
            let result = reponse.result
            switch result {
            case .success(let data):
                if let dictionary = data as? [String:Any] {
                    success(dictionary)
                }
                
            case .failure(let error):
                print("error - ", error.localizedDescription)
            }
        }
        
        request.responseJSON(completionHandler: responseHandler)
        
    }
    
}
