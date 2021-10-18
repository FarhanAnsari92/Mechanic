//
//  Brand.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/10/2021.
//

import ObjectMapper

class Brand {
    
    static let shared: Brand = Brand()
    var brands: [BrandModel]?
    
    private init() { }
    
    func getBrands(completion: @escaping ([BrandModel]?) -> Void) {
        
        if let brands = self.brands{
            completion(brands)
        }else{
            APIClient.callApi(api: .brands, method: .get) { [weak self] data in
                if let dictionary = data {
                    if let brandsResponse = Mapper<BrandResponseModel>().map(JSON: dictionary) {
                        self?.brands = brandsResponse.brands
                        completion(self?.brands)
                    }
                }
            }
        }
    }
}
