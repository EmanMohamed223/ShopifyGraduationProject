//
//  SaveCoreData.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 24/02/2023.
//

import Foundation
import CoreData

class SaveCoreData{
    func saveToCore(product : Products, userID : Int, appDelegate : AppDelegate){
        print(UserDefaultsManager.shared.getUserID())
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingCart", in: managedContext)

        let lineItemsArray = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        lineItemsArray.setValue(product.id, forKey: "productID")
        lineItemsArray.setValue(product.variants?[0].id, forKey: "userID")
        lineItemsArray.setValue(product.title, forKey: "title")
        lineItemsArray.setValue(product.variants?[0].price, forKey: "price")
        lineItemsArray.setValue(product.variants?[0].inventory_quantity, forKey: "quantity")
        //lineItemsArray.setValue(product.vendor, forKey: "img")
        lineItemsArray.setValue(product.images[0].src, forKey: "img")
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Error in Saving: ",error)
        }
    }
}
