//
//  APIClient.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 16/10/2021.
//

import Foundation
import Alamofire
import GoogleMaps

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
    case vehicle = "vehicles"
    case workShops = "work-shops"
    case address = "addresses"
    case job = "jobs"
    case updateInspectionDetails = "jobs/update-inspection-details"
    case products = "products"
    case orders = "orders"
    case categories = "categories"
    case inspectionTitles = "inspection-titles"
    
}

enum APIVersion: String {
    case v1 = "v1"
//    case v2 = "v2"
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

class APIClient {
    
    class func callApi(
        api: API,
        apiVersion: APIVersion = .v1,
        parameters: [String:String]? = nil,
        method: HTTPMethod,
        data: Data? = nil,
        view: UIView? = nil,
        success: @escaping (([String:Any]?) -> Void)) {        
        
        let path = apiVersion.rawValue + "/" + api.rawValue
        let url: URL = URL(string: path, relativeTo: BaseURL.staging)!
        
        if let _ = view {
            view?.showHud()
        }
        
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
        urlRequest.httpBody = data
        print("--- DATA --- ", data)
        if let user = User.shared.getUser(),
           let accessToken = user.accessToken {
            let headerValue = "Bearer \(accessToken)"
            print(headerValue)
            urlRequest.setValue(headerValue, forHTTPHeaderField: "Authorization")
        }
        
        print("URL - ", url.absoluteURL)
        
        let request = Alamofire.request(urlRequest)
        let responseHandler: ((DataResponse<Any>) -> Void) = { reponse in
            if let _ = view {
                view?.hideHud()
            }
            let result = reponse.result
            switch result {
            case .success(let data):
                if let dictionary = data as? [String:Any] {
                    if dictionary["success"] as? Bool ?? false {
                        success(dictionary)
                    } else {
                        if let message = dictionary["message"] as? String {
                            Helper.showMessage(text: message)
                        } else {
                            Helper.showMessage(text: "Something went wrong.")
                        }
                    }
                    
                } else {
                    Helper.showMessage(text: "Something went wrong.")
                }
                
            case .failure(let error):
                Helper.showMessage(text: error.localizedDescription)
            }
        }
        
        request.responseJSON(completionHandler: responseHandler)
        
    }
    
    class func multipartRequest(
        api: API,
        apiVersion: APIVersion = .v1,
        parameters: [String:String]? = nil,
        image: UIImage,
        method: HTTPMethod,
        view: UIView? = nil,
        success: @escaping ([String:Any]?) -> Void) {
        
        let path = apiVersion.rawValue + "/" + api.rawValue
        let url: URL = URL(string: path, relativeTo: BaseURL.staging)!
        let URLStr = url.absoluteString
        
        if let _ = view {
            view?.showHud()
        }
        
        Alamofire.upload(multipartFormData:
                            {
                                (multipartFormData) in
                                multipartFormData.append(image.jpegData(compressionQuality: 0.3)!, withName: "running_doc", fileName: "running_doc.jpeg", mimeType: "image/jpeg")
                                if let params = parameters {
                                    for (key, value) in params
                                    {
                                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                                    }
                                }
                            },
                         to:URLStr,
                         headers: ["Accept": "application/json", "Content-Type": "application/json", "Authorization": "Bearer \(User.shared.getUser()?.accessToken ?? "")"]
        )
        { (result) in
            if let _ = view {
                view?.hideHud()
            }
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseJSON
                { response in
                    if response.result.value != nil {
                        if let dictionary: [String:Any] = response.result.value! as? [String:Any] {
                            print("DATA UPLOAD SUCCESSFULLY")
                            success(dictionary)
                        }
                    }
                }
            case .failure(let error):
                if let _ = view {
                    view?.hideHud()
                }
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    class func uploadInspectData(
        api: API,
        apiVersion: APIVersion = .v1,
        parameters: [String:String]? = nil,
        images: [UIImage]? = nil,
        audioURL: URL? = nil,
        method: HTTPMethod,
        view: UIView? = nil,
        success: @escaping ([String:Any]?) -> Void) {
        
        let path = apiVersion.rawValue + "/" + api.rawValue
        let url: URL = URL(string: path, relativeTo: BaseURL.staging)!
        let URLStr = url.absoluteString
        
        if let _ = view {
            view?.showHud()
        }
        
        Alamofire.upload(multipartFormData:
                            {
                                (multipartFormData) in
                                if let images = images {
                                    for i in 0..<images.count {
                                        let image = images[i]
                                        
                                        multipartFormData.append(image.jpegData(compressionQuality: 0.3)!, withName: "images[\(i)]", fileName: "images[\(i)].jpeg", mimeType: "image/jpeg")
                                        
                                    }
                                }
                                
                                if let audioURL = audioURL {
                                    multipartFormData.append(audioURL, withName: "audio")
                                }
                                
                                if let params = parameters {
                                    for (key, value) in params
                                    {
                                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                                    }
                                }
                            },
                         to:URLStr,
                         headers: [
                            "Accept": "application/json",
                            "Content-Type": "application/json",
                            "Authorization": "Bearer \(User.shared.getUser()?.accessToken ?? "")"
                         ]
        )
        { (result) in

            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseJSON
                { response in
                    if response.result.value != nil {
                        if let dictionary: [String:Any] = response.result.value! as? [String:Any] {
                            if let _ = view {
                                view?.hideHud()
                            }
                            success(dictionary)
                        }
                    }
                }
            case .failure(let error):
                if let _ = view {
                    view?.hideHud()
                }
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    class func reversedGeocode(
        location: CLLocationCoordinate2D,
        completion: @escaping ((Any?) -> Void),
        errorCompletion: @escaping ((Error) -> Void)
    ) {
        let lat = location.latitude.description
        let lng = location.longitude.description
        let key = Constants.Google.directionAPIKey
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(lng)&key=\(key)"
        
        Alamofire.request(URL(string: url)!).responseJSON { response in
            
            let result = response.result
            switch result {
            case .success(let data):
                completion(data)
                
            case .failure(let error):
                errorCompletion(error)
            }
            
        }
        
    }
}
