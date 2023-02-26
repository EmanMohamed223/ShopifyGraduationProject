//
//  UserModel.swift
//  ShopfiyProject
//
//  Created by Eman on 23/02/2023.
//

import Foundation

struct UserResponse: Codable {
    let user: User
}

struct User : Codable {
    let customer: Customer
//    var first_name, email: String?
//    var id: Int?
//    var currency : String?
//    var phone : String?
//    var locale : String
    
}
