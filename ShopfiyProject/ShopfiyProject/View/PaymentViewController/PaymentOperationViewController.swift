//
//  PaymentOperationViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 26/02/2023.
//

import UIKit
import PassKit

class PaymentOperationViewController: UIViewController {
    
    @IBOutlet weak var paymentSegment: UISegmentedControl!
    
    var paymentViewModel = PaymentViewModel()
    var paymentRequest = PKPaymentRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func payBtn(_ sender: UIButton) {
        switch paymentSegment.selectedSegmentIndex{
        case 1:
            paymentViewModel.getPaymentRequest()
            paymentViewModel.bindPaymentRequestToViewController = { () in
                self.renderPaymentRequest(request: self.paymentViewModel.paymentRequest)
            }
            let paymentController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            if paymentController != nil{
                paymentController!.delegate = self
                present(paymentController!, animated: true)
            }
            print("AppleBay")
        default:
            print("Cash")
        }
    }
    
    func renderPaymentRequest(request : PKPaymentRequest?){
        self.paymentRequest = request ?? PKPaymentRequest()
    }
    

}

extension PaymentOperationViewController : PKPaymentAuthorizationViewControllerDelegate{
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true,completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
}
