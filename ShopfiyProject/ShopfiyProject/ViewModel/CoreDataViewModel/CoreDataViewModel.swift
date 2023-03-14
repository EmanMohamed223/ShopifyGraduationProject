//
//  CoreDataViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 06/03/2023.
//

import Foundation

class CoreDataViewModel{
    func callManagerToSave(product : Products, userID : Int, appDelegate: AppDelegate){
        CoreDataManager.getCoreObj().saveItems(product : product, userID: userID, appDelegate: appDelegate)
    }
    
    func callManagerToFetch(appDelegate : AppDelegate,userID : Int) -> [Products]?{
        return CoreDataManager.getCoreObj().fetchCoreData(appDelegate: appDelegate, userID: userID)
    }
    
    func callManagerToDelete(appDelegate : AppDelegate,productID : Int, userID : Int){
        CoreDataManager.getCoreObj().deleteFromCoreData(appDelegate: appDelegate, productID: productID, userID: userID)
    }
    
    func callManagerToDeleteAll(appDelegate : AppDelegate, userID : Int){
        CoreDataManager.getCoreObj().deleteAll(appDelegate: appDelegate, userID: userID)
    }
}
