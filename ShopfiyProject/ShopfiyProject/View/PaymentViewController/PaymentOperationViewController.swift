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
    
   let authorization = "sandbox_8h5229nh_jpbyz2k4fnvh6fvt"
    var paymentViewModel = PaymentViewModel()
    var paymentRequest = PKPaymentRequest()

    var braintreeClient: BTAPIClient!
    var arrayOrders : [Order] = []

    
 var braintreeClient: BTAPIClient!
    var arrayOrders : Orders?

    var orderVm : orderViewModel?

    var lineItems : [LineItem]?
    

    static var lineItems : [LineItem]?

    var prices : Price?
    var address : Customer_address?
   
     override func viewDidLoad() {
        super.viewDidLoad()
        // PaymentOperationViewController.lineItems = PaymentViewController.lineItems
          lineItems = PaymentViewController.lineItems
    }
    
    func startCheckout(){//sandbox_zjkyng8w_jpbyz2k4fnvh6fvt

        if paymentSegment.selectedSegmentIndex == 0{
            postOrder()
            let alert = UIAlertController(title: "Ordered Successfully", message: "The order will be arrived soon!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default){_ in
            })
            self.present(alert, animated: true)
        }
        else{
            braintreeClient = BTAPIClient(authorization: "sandbox_q7ftqr99_7h4b4rgjq3fptm87")//<<<mk
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
            let request = BTPayPalCheckoutRequest(amount: "2.32")
            request.currencyCode = UserDefaultsManager.shared.getCurrency() ?? "USD"
            payPalDriver.tokenizePayPalAccount(with: request) { responseNonce, error in
                if responseNonce != nil {
                    self.postOrder()
                }
                else if error != nil{
                    print("Error :\(error!)")
                }

            }
        }
    }
    
    
    @IBAction func payBtn(_ sender: UIButton) {
          postOrder()
       startCheckout()
        
    }
    
    func renderPaymentRequest(request : PKPaymentRequest?){
        self.paymentRequest = request ?? PKPaymentRequest()
    }
    
    func postOrder(){
   print("/////////////")

      orderVm = orderViewModel()

        var newOrder : [String : Any] = [
     "order" : [
            "confirmed" : true ,
            "contact_email" :  UserDefaultsManager.shared.getUserEmail() ?? "",
            "email" : UserDefaultsManager.shared.getUserEmail() ?? "" ,
            "currency": UserDefaultsManager.shared.getCurrency() ?? "EGP",
            "number" : 2 ,
            "order_status_url" : "asss",
            "current_subtotal_price": prices?.current_subtotal_price ?? "0.0",
           "current_total_discounts": prices?.current_total_discounts ?? "0.0" ,
            "current_total_price": prices?.current_total_price ?? "0.0",
       
            "line_items" : convertter(lineItems: lineItems ?? [])
                ]
                        ]
         NetworkService.shared.postDataToApi(url: getURL(endPoint: "orders.json")!, newOrder: newOrder)


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
