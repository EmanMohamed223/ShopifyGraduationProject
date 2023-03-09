//
//  FireActionInCategoryCellFavourite.swift
//  ShopfiyProject
//
//  Created by Eman on 04/03/2023.
//

import Foundation
protocol FireActionInCategoryCellFavourite {
    func showAlertdelet(title:String, message:String, complition:@escaping ()->Void) 
    func deleteFavourite(appDelegate: AppDelegate, product: Products) -> Void
 

}
