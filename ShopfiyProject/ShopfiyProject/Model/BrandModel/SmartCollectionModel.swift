//
//  SmartCollectionModel.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 05/12/1401 AP.
//

import Foundation
class SmartCollection: Decodable{
    var smart_collections : [Collections]
}
class Collections : Decodable{
    var id : Int
    var title:String
    var body_html: String
    var sort_order:String?
    var rules : [Rule]
    var published_scope : String
    var image: Image

}
class Rule : Decodable {
    var column   : String?
    var relation : String?
    var condition: String?
}
