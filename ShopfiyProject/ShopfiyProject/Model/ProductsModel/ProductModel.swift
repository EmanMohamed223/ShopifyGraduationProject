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
class Products : Decodable{
    var id:Int
    var title: String
    var body_html: String?
    var vendor :String?
    var created_at:String?
    var status:String?
    var tags :String?
    var variants:[variant]?
    var images :[Image]
    
}
class variant :Decodable{
    var option2 :String?
    var price : String?


}


class Image : Decodable{

    var src : String?

                }
