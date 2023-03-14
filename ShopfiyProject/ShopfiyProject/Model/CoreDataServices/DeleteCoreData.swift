//
//  DeleteCoreData.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 06/03/2023.
//

import Foundation
import CoreData

class DeleteCoreData : DeleteFromCoreProtocol{
    func deleteFromCoreData(appDelegate: AppDelegate,productID : Int ,userID : Int){
        let managedContext = appDelegate.persistentContainer.viewContext
        //3
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCart")
        //4
        //let myPredicate = NSPredicate(format: "userID == %@", "\(userID)", " && productID == %@",  "\(productID)")
        
        let myPredicate = NSPredicate(format: "userID == %@ && productID == %@", "\(userID)",  "\(productID)")
        
        fetchRequest.predicate = myPredicate
        do{
            let productToBeRemoved = try managedContext.fetch(fetchRequest)
            managedContext.delete(productToBeRemoved[0])
            do{
                try managedContext.save()
            }catch let error as NSError{
                print(error)
            }
        }catch let error as NSError{
            print(error)
        }
    }
    
    func deleteAllCoreData(appDelegate: AppDelegate,userID : Int){
        let managedContext = appDelegate.persistentContainer.viewContext
        //3
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCart")
        //4
        let myPredicate = NSPredicate(format: "userID == %@", "\(userID)")
        fetchRequest.predicate = myPredicate
        do{
            let productToBeRemoved = try managedContext.fetch(fetchRequest)
            for index in 0...(productToBeRemoved.count)-1{
                managedContext.delete(productToBeRemoved[index])
            }
           
            do{
                try managedContext.save()
            }catch let error as NSError{
                print(error)
            }
        }catch let error as NSError{
            print(error)
        }
    }
}
