//
//  ObjectMapperManager.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 23/10/2021.
//

import Foundation
import ObjectMapper

protocol Parcable {
    associatedtype T
    func map(dictionary: [String:Any]) -> T?
    func map(string: String) -> T?
}

class ObjectMapperManager<T: BaseMappable>: Parcable {
    
    func map(string: String) -> T? {
        return Mapper<T>().map(JSONString: string)
    }
    
    func map(dictionary: [String : Any]) -> T? {
        return Mapper<T>().map(JSON: dictionary)
    }
}

