//
//  User.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/10/2021.
//

import Foundation

class User {
    
    static let shared: User = User()
    
    private var user: UserModel?
    private init() { }
    
    func set(user: UserModel) {
        self.user = user
    }
    
    func getUser() -> UserModel? {
        return self.user
    }
    
}
