//
//  CoreDataManager.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 24/02/2023.
//

import Foundation

class CoreDataManager : SavetoCoreProtocol{
    
    private static var coreDataManager : CoreDataManager?
    public static func getCoreObj() -> CoreDataManager{
        if let obj = coreDataManager{
            return obj
        }
        else{
            coreDataManager = CoreDataManager()
            return coreDataManager!
        }
    }
    
    func saveItems(product : Products, userID : Int, appDelegate: AppDelegate) {
        let saveCoreData = SaveCoreData()
        saveCoreData.saveToCore(product: product, userID: userID, appDelegate: appDelegate)
    }

    func fetchCoreData(appDelegate: AppDelegate, userID : Int) -> [Products]?{
        let fetchCoreData = FetchCoreData()
        return fetchCoreData.fetchFromCore(appDelegate: appDelegate,userID: userID)
    }
}
