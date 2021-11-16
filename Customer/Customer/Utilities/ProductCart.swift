//
//  ProductCart.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 12/11/2021.
//

import Foundation

class ProductCart {
    
    private var products: [ProductModel]?
    
    private init() { }
    
    static let shared: ProductCart = ProductCart()
    
    var hasItem: Bool {
        return (self.products?.count ?? 0) > 0
    }
    
    func add(product: ProductModel) {
        if let _ = self.products {
            if let prod = self.products?.first(where: { $0 == product }) {
                prod.quantity = prod.quantity + 1
            } else {
                product.quantity = 1
                self.products?.append(product)
            }
        } else {
            var prdcts = [ProductModel]()
            product.quantity = 1
            prdcts.append(product)
            self.products = prdcts
        }
    }
    
    func getProducts() -> [ProductModel]? {
        return self.products
    }
    
    func getTotal() -> Int {
        var total: Int = 0
        self.products?.forEach({ product in
            let price = product.price ?? 0
            let quantity = product.quantity
            total += price * quantity
        })
        return total
    }
    
    func set(quantity: Int, to product: ProductModel) {
        if quantity == 0 {
            self.products?.removeAll(where: { $0 == product })
        } else {
            self.products?.first(where: { $0 == product })?.quantity = quantity
        }
    }
    
    func removeProducts() {
        self.products = nil
    }
    
}
