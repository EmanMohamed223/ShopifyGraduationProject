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
 // var handle: String
    var title:String
//      var updated_at:String
    var body_html: String
    //  var published_at:String
    var sort_order:String?
  
    //  var disjunctive: Bool
      var rules : [Rule]
      var published_scope : String
        
         var image: Image
//    {
//            "created_at":"2023-02-15T02:34:19-05:00",
//            "alt":null,
//            "width":1610,
//            "height":805,
//            "src":"https:\/\/cdn.shopify.com\/s\/files\/1\/0721\/3963\/7017\/collections\/a340ce89e0298e52c438ae79591e3284.jpg?v=1676446459"
//         }
}
class Rule : Decodable {
    var column   : String?
    var relation : String?
    var condition: String?
}
