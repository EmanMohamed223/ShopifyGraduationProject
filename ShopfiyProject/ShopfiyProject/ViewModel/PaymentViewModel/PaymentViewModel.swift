//
//  PaymentViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 02/03/2023.
//

import Foundation
import PassKit

class PaymentViewModel{
    
    var bindPaymentRequestToViewController : (()->()) = {}
    
    var paymentRequest : PKPaymentRequest?{
        didSet{
            bindPaymentRequestToViewController()
        }
    }
    
    func getPaymentRequest(){
        PaymentService.shared.paymentRequest { request in
            guard let request = request else {return}
            self.paymentRequest = request
        }
    }
}


