//
//  Customer.swift
//  ShopfiyProject
//
//  Created by Eman on 23/02/2023.
//

import Foundation
struct CustomerResponse: Codable {
    let customers: [Customer]
}

struct Customer: Codable {
    var first_name, email: String?
    var id: Int?
    var currency : String?
    var phone : String?
    var tags : String?
    var addresses: [Address]?
}

struct Address: Codable {
    var id : Int?
    var customer_id : Int?
    var address1 : String?
    var address2 : String?
    var city: String?
    var country: String?
    var phone : String?
   // var `default` : Bool?
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
