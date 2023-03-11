//
//
//  ProductDetailsViewModel.swift
//  ShopfiyProject
//
//  Created by Eman on 02/03/2023.
//

import Foundation
class ProductDetailsViewModel {
    let databaseManager = DatabaseManager()
    func getProductsInFavourites(appDelegate: AppDelegate, product: inout Products) -> Bool {
        var isFavourite: Bool = false
        
        if !UserDefaultsManager.shared.getUserStatus() {
           
            return isFavourite
        }
        
        product.userId = UserDefaultsManager.shared.getUserID()!
        var productsArray = [Products]()
        databaseManager.getItemFromFavourites(appDelegate: appDelegate, product: product) { (products, error) in
            if let products = products {
                productsArray = products
            }
        }
        
        for item in productsArray {
            if item.id == product.id {
                isFavourite = true
            }
        }
      
        return isFavourite
    }
    
    
    
    
    
    
    func addProductToFavourites(appDelegate: AppDelegate, product: Products) {
        databaseManager.addFavourite(appDelegate: appDelegate, product: product)
    }
    
    func removeProductFromFavourites(appDelegate: AppDelegate, product: Products) {
        databaseManager.deleteFavourite(appDelegate: appDelegate, product: product)
    }
    
    
    
    
    
    
    
    
}
