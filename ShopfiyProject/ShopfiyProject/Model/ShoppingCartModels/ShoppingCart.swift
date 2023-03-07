//
//  ShoppingCart.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 23/02/2023.
//

import Foundation


struct ShoppingCartResponseArray : Codable{
    var draft_orders : [ShoppingCartClass]?
}


struct ShoppingCartResponse : Codable{
    var draft_order : ShoppingCartClass?
}

struct ShoppingCartClass : Codable {
    
    var id : Int?
    var name : String?
    var email : String?
    var line_items : [LineItem]?
    var taxes_included : Bool?
    var currency : String?
    var invoice_sent_at : String?
    var created_at : String?
    var updated_at : String?
    var tax_exempt : Bool?
    var completed_at : String?
    var note : String?
    var status : String?
    //var line_items : [Products]?
}

