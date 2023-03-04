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
    
    func saveItems(userRelated: UserRelatedStruct, appDelegate: AppDelegate) {
        let saveCoreData = SaveCoreData()
        saveCoreData.saveToCore(userRelated: userRelated, appDelegate: appDelegate)
    }

    
}
