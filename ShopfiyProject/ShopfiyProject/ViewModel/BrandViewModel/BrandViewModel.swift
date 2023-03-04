//
//  BrandViewModel.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 12/12/1401 AP.
//

import Foundation
class BrandViewModel{
    var bindResultToHomeViewController : (() -> ()) = {}
     var resultBrands : SmartCollection! {
         didSet{
             bindResultToHomeViewController()
         }
     }
    func getBrands(url : String?){
        NetworkService.fetchData(url: url) { result in
            self.resultBrands = result
        }
    }
}
