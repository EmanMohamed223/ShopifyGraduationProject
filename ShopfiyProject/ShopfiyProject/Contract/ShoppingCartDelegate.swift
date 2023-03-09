//
//  ShoppingCartDelegate.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 28/02/2023.
//

import Foundation


protocol ShoppingCartDelegate{
//    func increaseNumberOfItems() -> (Int)?
//    func decreaseNumberOfItems() -> (Int)?
//    func getPrice(price : String)
    func calcSubTotalInc(price : String)
    func calcSubTotalDec(price : String)
}
