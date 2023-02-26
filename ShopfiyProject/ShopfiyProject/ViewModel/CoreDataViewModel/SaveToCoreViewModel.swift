//
//  SaveToCoreViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 24/02/2023.
//

import Foundation

class SavetoCoreViewModel{
    func callManagerToSave(userRelated: UserRelatedStruct, appDelegate: AppDelegate){
        CoreDataManager.getCoreObj().saveItems(userRelated: userRelated, appDelegate: appDelegate)
    }
}
