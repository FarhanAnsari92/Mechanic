//
//  GoogleHelper.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/24/21.
//

import Foundation
import GoogleMaps

class GoogleHelper {
    
    class func getAddress(
        location: CLLocationCoordinate2D,
        completion: @escaping (([String:Any]) -> Void),
        error: @escaping ((String) -> Void)
    ) {
        
        APIClient.reversedGeocode(location: location, completion: { rawData in
            if let data = rawData {
                if let dictionary = data as? [String:Any] {
                    completion(dictionary)
                } else {
                    error("Unable to parse.")
                }
            } else {
                error("Not responding.")
            }
        }) { er in
            error(er.localizedDescription)
        }
        
    }
    
}
