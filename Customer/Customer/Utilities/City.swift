//
//  City.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/10/2021.
//

class City {
    
    static let shared: City = City()
    var cities: [CityModel]?
    
    private init() { }
    
    func getCities(completion: @escaping ([CityModel]?) -> Void) {
        if let cities = self.cities {
            completion(cities)
        } else {
            APIClient.callApi(api: .cities, method: .get) { [weak self] data in
                if let dictionary = data {
                    if let cities = ObjectMapperManager<CityResponseModel>().map(dictionary: dictionary) {
                        self?.cities = cities.data
                        completion(self?.cities)
                    }
                }
            }
        }
    }
    
}
