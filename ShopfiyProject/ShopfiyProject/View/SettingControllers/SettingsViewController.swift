//
//  SettingsViewController.swift
//  ShopifyProj
//
//  Created by Mariam Moataz on 19/02/2023.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addressBtn(_ sender: Any) {
    }
    
    @IBAction func currencyBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Currency", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "EGP", style: .default, handler: { _ in
            self.currencyLabel.text = "EGP"
            UserDefaultsManager.shared.setCurrency(currency: "EGP")
        }))
        alert.addAction(UIAlertAction(title: "USD", style: .default, handler: {_ in
            self.currencyLabel.text = "USD"
            UserDefaultsManager.shared.setCurrency(currency: "USD")
        }))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func contactBtn(_ sender: Any) {
        
    }
    
    
    @IBAction func aboutBtn(_ sender: Any) {
    }
    
    @IBAction func logoutBtn(_ sender: Any) {

        UserDefaultsManager.shared.setUserStatus(userIsLogged: false)
        self.navigationController?.popViewController(animated: true)
    }
    
}
