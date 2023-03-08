//
//  PaymentOperationViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 26/02/2023.
//

import UIKit
import PassKit
import Braintree
import BraintreeDropIn

class PaymentOperationViewController: UIViewController {
    
    @IBOutlet weak var paymentSegment: UISegmentedControl!
    
    //let authorization = "sandbox_8h5229nh_jpbyz2k4fnvh6fvt"
    var paymentViewModel = PaymentViewModel()
    var paymentRequest = PKPaymentRequest()
    var braintreeClient: BTAPIClient!
    
    var orderVm : orderViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func startCheckout(){//sandbox_zjkyng8w_jpbyz2k4fnvh6fvt
        braintreeClient = BTAPIClient(authorization: "sandbox_q7ftqr99_7h4b4rgjq3fptm87")//<<<mk
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
                //payPalDriver.viewControllerPresentingDelegate = self
        
               // payPalDriver.appSwitchDelegate = self // Optional
        
        let request = BTPayPalCheckoutRequest(amount: "2.32")
        request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options

        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                // Access additional information
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone

                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
                // Handle error here...
            } else {
                // Buyer canceled payment approval
            }
        }
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCanceled == true) {
                print("CANCELED")
            } else if let result = result {
                 //Use the BTDropInResult properties to update your UI
//                result.paymentMethodType
//                 result.paymentMethod
//                 result.paymentIcon
//                 result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    @IBAction func payBtn(_ sender: UIButton) {
        //showDropIn(clientTokenOrTokenizationKey: "sandbox_q7ftqr99_7h4b4rgjq3fptm87")
        startCheckout()
        //postOrder()
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

extension PaymentOperationViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }

    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}
