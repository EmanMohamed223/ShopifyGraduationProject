//
//  DatabaseManager.swift
//  ShopfiyProject
//
//  Created by Eman on 02/03/2023.
//

import Foundation
import CoreData
class DatabaseManager : DatabaseProtocol
{
    func addFavourite(appDelegate: AppDelegate, product: Products) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Favourite", in: managedContext)
            
        let coreDataProduct = NSManagedObject(entity: entity!, insertInto: managedContext)
        coreDataProduct.setValue(product.id , forKey: "id")
        coreDataProduct.setValue(product.userId , forKey: "userID")
        coreDataProduct.setValue(product.variants?[0].price ?? "0.0", forKey: "price")
        coreDataProduct.setValue(product.title, forKey: "title")
        coreDataProduct.setValue(product.images[0].src, forKey: "imgUrl")
        do{
            try managedContext.save()
            print(" saved ")
        }catch let error as NSError{
            print("failed to save  \(error.localizedDescription)")
        }
    }
    
    func getFavourites(appDelegate: AppDelegate, userId: Int, complition: @escaping ([Products]?, Error?) -> Void) {
        var favouriteList = [Products]()
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
        fetchRequest.predicate = NSPredicate(format: "userID = \(userId)")
        do{
            let productArray = try managedContext.fetch(fetchRequest)
            print("fetching done")
            for product in productArray{
                let id = product.value(forKey: "id") as! Int
                let userID = product.value(forKey: "userID") as! Int
                let price = product.value(forKey: "price") as! String
                let title = product.value(forKey: "title") as! String
                let imgUrl = product.value(forKey: "imgUrl") as! String
           
      
                let product = Products(id: id, title: title, variants: [variant(option2: price)], images: [Image( src: imgUrl)],userId: userID)
                    favouriteList.append(product)
            }
            complition(favouriteList, nil)
        }catch{
            print("failed to fetch  \(error.localizedDescription)")
            complition(nil, error)
        }
    }
    
    func getItemFromFavourites(appDelegate: AppDelegate, product: Products, complition: @escaping ([Products]?, Error?) -> Void) {
        var favouriteList = [Products]()
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
        fetchRequest.predicate = NSPredicate(format: "userID = \(product.userId ?? 0) AND id = \(product.id)")
        do{
            let productArray = try managedContext.fetch(fetchRequest)
      
            for product in productArray{
                let id = product.value(forKey: "id") as! Int
                let userID = product.value(forKey: "userID") as! Int
                let price = product.value(forKey: "price") as! String
                let title = product.value(forKey: "title") as! String
                let imgUrl = product.value(forKey: "imgUrl") as! String
                
               
                let product = Products(id: id, title: title, variants: [variant(option2: price)], images: [Image( src: imgUrl)],userId: userID)
                   
                    favouriteList.append(product)
            }
            complition(favouriteList, nil)
        }catch{
            print("failed fetching   \(error.localizedDescription)")
            complition(nil, error)
        }
    }
    
   func deleteFavourite(appDelegate: AppDelegate, product: Products) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
       fetchRequest.predicate = NSPredicate(format: "id = \(product.id) AND userID = \(product.userId ?? 1)")
      do{
           let productsArray = try managedContext.fetch(fetchRequest)
           for product in productsArray {
             managedContext.delete(product)
          }
            try managedContext.save()
            print("deleted ")
        }catch{
            print("failed delete  \(error)")
        }
    }
    
    
}
