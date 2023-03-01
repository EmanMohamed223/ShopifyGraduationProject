//
//  ShoppingCart.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 23/02/2023.
//

import Foundation


class ShoppingCartResponse : Codable{
    var draft_order : ShoppingCart?
}

class ShoppingCart : Codable {
    
    var id : Int?
    var note : String?
    var email : String?
    var taxes_included : Bool
    var currency : String?
    var invoice_sent_at : String?
    var created_at : String?
    var updated_at : String?
    var tax_exempt : Bool?
    var completed_at : String?
    var name : String?
    var status : String?
    var line_items : [Products]?
}

