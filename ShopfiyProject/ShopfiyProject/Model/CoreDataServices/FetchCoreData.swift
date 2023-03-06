//
//  FetchCoreData.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 06/03/2023.
//

import Foundation
import CoreData

class FetchCoreData{
    func fetchFromCore(appDelegate: AppDelegate, userID : Int) -> [Products]?{
        let formatter = ConvertToProductFormatter()
        print(UserDefaultsManager.shared.getUserID()!)
        var productsNSManagedObject : [NSManagedObject] = []
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        //3
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"ShoppingCart")
        //4
        let myPredicate = NSPredicate(format: "userID == %@", "\(userID)")
        fetchRequest.predicate = myPredicate
        do{
            productsNSManagedObject = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("Error in Fetching: \n",error)
        }
        
        return formatter.convertToProductFormatter(nsManagedObject: productsNSManagedObject)
    }
}
