//
//  Currency.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 19/12/1401 AP.
//

import Foundation

func calcCurrency(price: String?) -> String{
    switch UserDefaultsManager.shared.getCurrency(){
    case "EGP":
    return price ?? ""
    case "USD":
        let format = Double(price ?? "0")
        return String((format ?? 0.0 ) * 30)
    default:
        return ""
    }
}