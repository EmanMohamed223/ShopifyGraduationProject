//
//  ProductFavViewModel.swift
//  ShopfiyProject
//
//  Created by Eman on 04/03/2023.
//

import Foundation
class ProductFavViewModel {
    var dataBaseManager = DatabaseManager()
//    func getProductsInFavourites(appDelegate: AppDelegate, product: inout Products) -> Bool {
//        var isFavourite: Bool = false
//        if !UserDefaultsManager.shared.getUserStatus() {
//            return isFavourite
//        }
//
//        var productsArray = [Products]()
//        product.variants![0].id = UserDefaultsManager.shared.getUserID()!
//        dataBaseManager.getItemFromFavourites(appDelegate: appDelegate, product: product, complition: { (products, error) in
//            if let products = products {
//                productsArray = products
//            }
//        })
//
//        for item in productsArray {
//            if item.id == product.id {
//                isFavourite = true
//            }
//        }
//        return isFavourite
//    }
    
    func addFavourite(appDelegate: AppDelegate, product: Products){
        dataBaseManager.addFavourite(appDelegate: appDelegate, product: product)
    }
    
    func deleteFavourite(appDelegate: AppDelegate, product: Products){
        dataBaseManager.deleteFavourite(appDelegate: appDelegate, product: product)
    }
    
}
