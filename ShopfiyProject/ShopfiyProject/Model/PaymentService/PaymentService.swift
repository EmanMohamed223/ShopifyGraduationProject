//
//  PaymentService.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 02/03/2023.
//

import Foundation
import PassKit

class PaymentService{
    
    static var shared = PaymentService()
    
    func paymentRequest(completion : (PKPaymentRequest?)->(Void)){
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchantID"
        request.supportedNetworks = [.quicPay, .masterCard, .visa]
        request.supportedCountries = ["EG","US"]
        request.merchantCapabilities = .capability3DS //support 3d secure protocol
        request.couponCode = "EG"
        request.currencyCode = "EGP"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "iphone", amount: 12500)]
        
        completion(request)
    }
}
