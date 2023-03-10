//
//  Orders.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 13/12/1401 AP.
//

import Foundation
struct Orders : Codable{
    var orders : [Order]
}
struct Orderrs : Codable {
    var order : [Order]
}
struct Order : Codable {
   var id :Int?
    var admin_graphql_api_id : String?
   var confirmed: Bool?
   var contact_email:String?
    var email : String?
   var created_at:String?
   var currency:String?
   var current_subtotal_price:String?
    var current_total_discounts:String?
    var current_total_price :String?

    var number : Int?
   var order_number : Int?

   var order_status_url: String?
    var line_items : [LineItem]?

}
