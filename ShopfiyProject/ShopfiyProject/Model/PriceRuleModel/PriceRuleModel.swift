//
//  PriceRuleModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 27/02/2023.
//

import Foundation


class DiscountCodeResponse : Decodable{
    var discount_codes : [DiscountCode]?
}

class DiscountCode : Decodable{
    var id : Int?
    var price_rule_id : Int?
    var code : String?
    var usage_count : Int?
    var created_at : String?
    var updated_at : String?
}
