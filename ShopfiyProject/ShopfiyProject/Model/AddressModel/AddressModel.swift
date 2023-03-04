//
//  AddressModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 02/03/2023.
//

import Foundation

struct CustomerAddressGetModel : Codable{ //getResponse model
    var addresses : [Customer_address]?
}

struct CustomerAddressModel : Codable{ //response model
    var customer_address : Customer_address?
}

struct Customer_address : Codable{
    var id : Int64?
    var country : String?
    var city : String?
    var address1 : String?
}
