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

struct Products : Decodable{
    var id:Int
    var title: String
    var body_html: String?
    var vendor :String?
    var created_at:String?
    var status:String?
    var tags :String?
    var variants:[variant]?
    var images :[Image]
    var userId : Int?
    
    init (){
        id=0
        title=""
        body_html=""
        vendor=""
        created_at=""
        status=""
        tags=""
        variants = [variant()]
        images = [Image()]
        userId = 0
    }
    
    init(id : Int?,title : String?, body_html : String?, vendor : String?, created_at : String?, status : String?, tags : String?, variants : [variant]?, images : [Image]? , userId : Int? ) {
        self.id = id ?? 0
        self.title = title ?? ""
        self.body_html = body_html ?? ""
        self.vendor = vendor ?? ""
        self.created_at = created_at ?? ""
        self.tags = tags ?? ""
        self.variants = variants ?? []
        self.images = images ?? []
        self.userId = userId ?? 0
    }
    init(id : Int?,title : String?, variants : [variant]?, images : [Image]? , userId : Int? ) {
        self.id = id ?? 0
        self.title = title ?? ""
        self.variants = variants ?? []
        self.images = images ?? []
        self.userId = userId ?? 0
    }
    
    
    init(id: Int, title: String, variants: [variant], images: [Image]){
        self.id = id
        self.title = title
        self.variants = variants
        self.images = images
    }
    
}
struct variant :Decodable{
    //userID
    var id : Int?
    var option2 :String?
    var price : String?
    var option1 : String?
    var inventory_quantity : Int?
    var old_inventory_quantity : Int?
    
    init(){
        id = 0
        option2 = ""
        price = ""
        option1 = ""
        inventory_quantity = 0
        old_inventory_quantity = 0
    }
    
    init(id : Int? ,option2 : String?){
        self.id = id
        self.option2 = option2
    }
    init(option2 : String?){
        self.option2 = option2
    }
}


struct Image : Decodable{

    var src : String?
}
