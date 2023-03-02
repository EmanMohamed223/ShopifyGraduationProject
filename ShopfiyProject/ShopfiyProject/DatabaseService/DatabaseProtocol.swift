//
//  DatabaseProtocol.swift
//  ShopfiyProject
//
//  Created by Eman on 02/03/2023.
//

import Foundation
protocol DatabaseProtocol
{
    func addFavourite(appDelegate: AppDelegate, product: Products)
    func getFavourites(appDelegate: AppDelegate, userId: Int, complition: @escaping ([Products]?, Error?)->Void)
    func getItemFromFavourites(appDelegate: AppDelegate, product: Products, complition: @escaping ([Products]?, Error?)->Void)
    func deleteFavourite(appDelegate: AppDelegate, product: Products)
}
