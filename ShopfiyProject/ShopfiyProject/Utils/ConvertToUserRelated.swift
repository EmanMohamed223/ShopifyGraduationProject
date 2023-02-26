//
//  ConvertToUserRelated.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 24/02/2023.
//

import Foundation
import CoreData

class ConvertToUserRelated{
    var userRelatedData : [NSManagedObject]!
    func convertToLeagueFormatter(nsManagedObject : [NSManagedObject]) -> [UserRelated]?{
        guard !nsManagedObject.isEmpty else{return nil}
        var userRelatedDataArr : [UserRelated] = []
        for objectIndex in 0...nsManagedObject.count-1{
            let userRelated = UserRelated()
            userRelated.offerCoupon = nsManagedObject[objectIndex].value(forKey: "offerCoupon") as? String ?? ""
            userRelatedDataArr.append(userRelated)
        }
        return userRelatedDataArr
    }
}
