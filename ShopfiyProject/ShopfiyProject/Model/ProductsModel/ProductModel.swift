//
//  ProductModel.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 04/12/1401 AP.
//

import Foundation
class ResponseProducts : Decodable {
    var products :[Products]
}
class Products : Decodable {
    var id:Int
    var title: String
    var body_html: String?
    var vendor :String?
    var created_at:String?
    var status:String?
    var tags :String?
    var variants:[variant]?
    var images :[Image]
//    var product_type: String?

//    var handle:String?
 //  var updated_at :String?
//     var published_at:String?
    
  
    //var published_scope : String?

          
  //    var options:[option]

    

}
class variant :Decodable {
    var option2 :String?
    var price : String?
//    var id : Int?
//    var product_id : Int?
//    var title:String?
    
//    var sku : String?
//    var position : String?
//    var inventory_policy : String?
    //
   // var compare_at_price:String?
//    var fulfillment_service :String?
//    var inventory_management : String?
   // var option1 : String?
    
//    var option3:String?
//    var created_at :String?
//    var updated_at :String?
//    var taxable :Bool?
    //
   // var barcode : String?
   // var grams : Int?
//    var image_id: String?
 //   var weight : Float?
 //   var weight_unit: String?
//    var inventory_item_id: Int?
//    var inventory_quantity: Int?
//    var old_inventory_quantity:Int?
//    var requires_shipping :Bool?


}
class option : Decodable{
    
    var id :Int?
    var product_id : Int?
    var name :String?
    var position : Int?
    var values:[String?]?
}
class Image : Decodable{
//    var id : Int?
//    var product_id:Int?
//    var position:Int?
//    var created_at:String?
//    var updated_at :String?
//
//    var width:Int?
//   var height:Int?
    var src : String?

                }
