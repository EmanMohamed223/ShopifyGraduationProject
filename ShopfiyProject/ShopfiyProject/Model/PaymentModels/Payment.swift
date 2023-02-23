//
//  Payment.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 23/02/2023.
//

import Foundation

class Payment : Decodable{
    var id : Int?
    var unique_token : String?
    var payment_processing_error_message : String?
    var next_action : [String : String]?
}
