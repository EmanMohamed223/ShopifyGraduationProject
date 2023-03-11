//
//  ProductFavViewModel.swift
//  ShopfiyProject
//
//  Created by Eman on 04/03/2023.
//

import Foundation
class ProductFavViewModel {
    var dataBaseManager = DatabaseManager()

    func addFavourite(appDelegate: AppDelegate, product: Products){
        dataBaseManager.addFavourite(appDelegate: appDelegate, product: product)
    }
    
    func deleteFavourite(appDelegate: AppDelegate, product: Products){
        dataBaseManager.deleteFavourite(appDelegate: appDelegate, product: product)
    }
    
}
