//
//  PaymentViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 21/02/2023.
//

import UIKit

class PaymentViewController: UIViewController {

    
    
    @IBOutlet weak var paymentSegment: UISegmentedControl!
   
    
    @IBOutlet weak var countryLabel: UILabel!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    
    @IBOutlet weak var shippingFeesLabel: UILabel!
    @IBOutlet weak var couponTxtField: UITextField!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func validateBtn(_ sender: Any) {
    }
    
    @IBAction func placeOrderBtn(_ sender: Any) {
    }
    
}
