//
//  AddressModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 02/03/2023.
//

import Foundation

struct AddressModel : Codable{
    var customerId : Int?
    var country : String?
    var city : String?
    var street : String?
}

struct Customer_addressResponseModel : Codable{
    var customer_address : Customer_address?
}

struct Customer_address : Codable{
    //var customer_id : Int?
    var country : String?
    var city : String?
    var address1 : String?
}
