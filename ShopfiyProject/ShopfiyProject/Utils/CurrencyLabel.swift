//
//  CurrencyLabel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 12/03/2023.
//

import Foundation

func setCurrencyLabel() -> String{
    if UserDefaultsManager.shared.getCurrency() == "USD"{
        return "USD"
    }
    else{
        return "EGP"
    }
}
