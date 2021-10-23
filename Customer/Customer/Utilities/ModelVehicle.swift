//
//  ModelVehicle.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/10/2021.
//

class ModelVehicle {
    
    static let shared: ModelVehicle = ModelVehicle()
    var models: [VehicleModel]?
    
    private init() { }
    
    func getModel(completion: @escaping ([VehicleModel]?) -> Void) {
        
        if let models = self.models {
            completion(models)
        }else{
            APIClient.callApi(api: .model, method: .get) { [weak self] data in
                if let dictionary = data {
                    if let modelResponse = ObjectMapperManager<VehicleResponseModel>().map(dictionary: dictionary) {
                        self?.models = modelResponse.models
                        completion(self?.models)
                    }
                }
            }
        }
    }
}
