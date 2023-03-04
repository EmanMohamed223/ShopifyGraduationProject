//
//  FavoritesViewModel.swift
//  ShopfiyProject
//
//  Created by Eman on 04/03/2023.
//

import Foundation
class FavoritesViewModel {
    var databaseManager = DatabaseManager()
    var favoritesArray: [Products]? {
        didSet {
            bindingData(favoritesArray, nil)
        }
    }

    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    var bindingData: (([Products]?,Error?) -> Void) = {_, _ in }

    func fetchfavorites(appDelegate: AppDelegate, userId: Int) {
        databaseManager.getFavourites(appDelegate: appDelegate, userId: userId) { favorites, error in
            
            if let favorites = favorites {
                self.favoritesArray = favorites
            }
            
            if let error = error {
                self.error = error
            }
        }
    }
    func deleteFavourite(appDelegate: AppDelegate, product: Products){
        databaseManager.deleteFavourite(appDelegate: appDelegate, product: product)
    }
}
