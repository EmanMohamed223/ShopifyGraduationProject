//
//  HelperFunctions.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 27/02/2023.
//

import Foundation

func getURL(endPoint : String?)->(String?){
    
    return "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/\(endPoint ?? "")"
}

func chooseMainCategory (index : Int) -> String{
    var mainCategory = ["?collection_id=437787230489" , "?collection_id=437787263257" , "?collection_id=437787296025" , "?collection_id=437787328793"]
    return mainCategory[index]
}
