//
//  FireActionInCategoryCellProtocol.swift
//  ShopfiyProject
//
//  Created by Eman on 04/03/2023.
//

import Foundation
//product
protocol FireActionInCategoryCellProtocol {
    func addFavourite(appDelegate: AppDelegate, product: Products) -> Void
    func deleteFavourite(appDelegate: AppDelegate, product: Products) -> Void
    func showAlert(title: String, message: String) -> Void
    func showAlertdelet(title:String, message:String, complition:@escaping ()->Void) 
}
