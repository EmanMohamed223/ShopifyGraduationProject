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
    var orderVm : orderViewModel?
  
   
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
        postOrder()
    }
    
    func renderPaymentRequest(request : PKPaymentRequest?){
        self.paymentRequest = request ?? PKPaymentRequest()
    }
    
    func postOrder(){
     
        let newOrder  : [String : Any] = [
            "order" : [
                "confirmed" : true ,
                "contact_email" : "@mmm",
                "currency": "EGP",
                "created_at" : "20-2-2015",
                "number" : 2 ,
                "order_number" : 123 ,
                "order_status_url" : "",
                "current_subtotal_price": "15.0",
                "current_total_discounts": "0.2",
                "current_total_price": "15.0",
                "line_items" : [[
                 "fulfillable_quantity" : 5,
                 "name":"Egypt",
                 "price":"0.10",
                 "quantity" : 3,
                 "sku" : "asmaa",
                 "title" : "Shooes"
                ]]
            ]
        ]
        orderVm = orderViewModel()
        orderVm?.postOrder(order: newOrder)
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
