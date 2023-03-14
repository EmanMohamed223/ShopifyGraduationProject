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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        if UserDefaultsManager.shared.getCurrency() != nil || UserDefaultsManager.shared.getCurrency() == ""{
            currencyLabel.text = UserDefaultsManager.shared.getCurrency()
        }
        else{
            currencyLabel.text = "EGP"
        }
    }
    
    @IBAction func addressBtn(_ sender: Any) {
        AddressViewController.flag = true
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
    
    @IBAction func logoutBtn(_ sender: Any) {

        UserDefaultsManager.shared.setUserStatus(userIsLogged: false)
        UserDefaultsManager.shared.setDraftFlag(draftFlag: false)
        UserDefaultsManager.shared.setDraftOrderID(draftOrderID: nil)
        UserDefaultsManager.shared.setUserID(customerID: nil)
        UserDefaultsManager.shared.setUserName(userName: nil)
        UserDefaultsManager.shared.setUserEmail(userEmail: nil)
        UserDefaultsManager.shared.setCurrency(currency: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
