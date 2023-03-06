//
//  ConvertToProductFormatter.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 06/03/2023.
//

import Foundation
import CoreData

class ConvertToProductFormatter : ConvertToProductDetailsProtocol{
    func convertToProductFormatter(nsManagedObject: [NSManagedObject]) -> [Products]? {
        
        guard !nsManagedObject.isEmpty else{return nil}
        var productsArray : [Products] = []
        for objectIndex in 0...nsManagedObject.count-1{
            var product = Products()
            product.id = nsManagedObject[objectIndex].value(forKey: "productID") as? Int ?? 0
            print("product ID: ",product.id)
            product.title = nsManagedObject[objectIndex].value(forKey: "title") as? String ?? " "
            //product.vendor = nsManagedObject[objectIndex].value(forKey: "img") as? String ?? " "
            product.images[0].src = nsManagedObject[objectIndex].value(forKey: "img") as? String ?? " "
            product.variants?[0].price = nsManagedObject[objectIndex].value(forKey: "price") as? String ?? " "
            product.variants?[0].id = nsManagedObject[objectIndex].value(forKey: "userID") as? Int ?? 0
            product.variants?[0].inventory_quantity = nsManagedObject[objectIndex].value(forKey: "quantity") as? Int ?? 0
            productsArray.append(product)
        }
        return productsArray
        
        
    }
    
    
}
 
