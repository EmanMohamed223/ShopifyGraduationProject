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

}
