//
//  Orders.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 13/12/1401 AP.
//

import Foundation
struct Orders : Decodable{
    var orders : [Order]
}
struct Order : Decodable {
   var id :Int

   var confirmed: Bool
   var contact_email:String?
   var created_at:String
   var currency:String?
   var current_subtotal_price:String
    var email : String?
   var current_total_discounts:String
   var current_total_price :String
   var number : Int
   var order_number : Int?
   var order_status_url: String?
    var line_items : [LineItem]?
}
