//
//  PriceRuleViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 27/02/2023.
//

import Foundation


class DiscountCodeViewModel{
    
    var bindResultToViewController : (() -> ()) = {}
    
    var discountCodeResponse : DiscountCodeResponse! {
        didSet{
            bindResultToViewController()
        }
    }

    func getPriceRules(url : String?){
        NetworkService.shared.fetchData(url: url) { result in
            self.discountCodeResponse = result
        }
    }
}

