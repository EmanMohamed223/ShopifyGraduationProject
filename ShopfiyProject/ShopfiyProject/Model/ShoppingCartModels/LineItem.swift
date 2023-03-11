//
//  LineItem.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 23/02/2023.
//

import Foundation

struct LineItem : Codable{
    
    var id : Int?
    var variant_id : Int?
    var product_id : Int?
    var title : String?
    var variant_title : String?
    var sku : String?
    var vendor : String? //img
    var quantity : Int?
    var requires_shipping : Bool?
    var taxable : Bool?
    var gift_card : Bool?
    var price : String?
    var name : String?
    var fulfillment_service : String?
    var grams : Int?
    //var tax_lines": [],
    var fullfillabel_quantity : String?
    //var properties : [],
    var custom : Bool?
    var admin_graphql_api_id : String?
}
