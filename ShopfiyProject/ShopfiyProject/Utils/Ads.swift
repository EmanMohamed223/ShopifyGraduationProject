//
//  Ads.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 24/02/2023.
//

import Foundation

func getAds() -> [AdsDetials]{

    let ad1 = AdsDetials(code: "summerOffer",discount: 50, image: "ads1")
    let ad2 = AdsDetials(code: "newOffer",discount: 50, image: "ads2")
    let ad3 = AdsDetials(code: "t-shirtsOffer",discount: 50, image: "ads3")
    let ad4 = AdsDetials(code: "fashionSaleOffer",discount: 50, image: "ads4")
    
    var ads : [AdsDetials] = []
   
    ads.append(ad1)
    ads.append(ad2)
    ads.append(ad3)
    ads.append(ad4)
    
    return ads
}
