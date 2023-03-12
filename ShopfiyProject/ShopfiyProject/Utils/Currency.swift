//
//  Currency.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 19/12/1401 AP.
//

import Foundation

func calcCurrency(price: String?) -> String{
    switch UserDefaultsManager.shared.getCurrency() ?? "EGP"{
    case "EGP":
    return price ?? ""
    case "USD":

        let format = Float(price ?? "0")
        return String(format: "%.2f", (format ?? 0.0 ) / 30)

    default:
        return ""
    }
}
