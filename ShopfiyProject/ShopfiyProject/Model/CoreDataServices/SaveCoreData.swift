//
//  SaveCoreData.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 24/02/2023.
//

import Foundation
import CoreData

class SaveCoreData{
    func saveToCore(userRelated : UserRelatedStruct, appDelegate : AppDelegate){
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "UserRelated", in: managedContext)

        let userRelatedArray = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        userRelatedArray.setValue(userRelated.offerCoupon, forKey: "offerCoupon")
        userRelatedArray.setValue(userRelated.userId, forKey: "userId")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Error in Saving: ",error)
        }
    }
}
