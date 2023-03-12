//
//  MeViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 21/02/2023.
//

import UIKit
import SwiftUI

class MeViewController: UIViewController ,Navigationdelegate {
   
    
   
    
    
    var orderArr : [Order]?
    
   

    @IBOutlet weak var thisView: UIView!
    @IBOutlet weak var welcomeOrAskingLabel: UILabel!
    @IBOutlet weak var ordersTable: UITableView!
    
    @IBOutlet weak var wishlistcollection: UICollectionView!
    
    @IBOutlet weak var cardBtm: UIBarButtonItem!
    override func viewWillAppear(_ animated: Bool) {
        updateView()
        self.navigationController?.tabBarItem.isEnabled = true
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
      
    }
    
    @IBAction func cartNavigate(_ sender: UIButton) {
        let SecondStoryBoard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        let view = SecondStoryBoard.instantiateViewController(withIdentifier: "secondStoryboard1") as! ShoppingCartViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    @IBAction func settingNavigate(_ sender: UIButton) {
        let SecondStoryBoard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        let view = SecondStoryBoard.instantiateViewController(withIdentifier: "secondStoryboard2") as! SettingsViewController
        self.navigationController?.pushViewController(view, animated: true)
        
    }
    func navigateToSignup() {
        let view : SignUpScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpScreenViewController
          self.navigationController?.pushViewController(view, animated: true)
    }
    func Tapfavourite(){
        let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
        let view = ThirdStoryBoard.instantiateViewController(withIdentifier: "favorite") as! WishListViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    func TapproductDetails(){
        let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
        let view = ThirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    func navigateToSignIn() {
        let loginview :LoginScreenViewController = self.storyboard?.instantiateViewController(withIdentifier:"login") as! LoginScreenViewController
              self.navigationController?.pushViewController(loginview, animated: true)
    }

    func navigateToMoreOrders() {
        let seemoreOrders = self.storyboard?.instantiateViewController(withIdentifier: "seemoreorder") as! MoreOrdersViewController
       
           self.present(seemoreOrders, animated: true)
    }
    func present(alert: UIAlertController) {
        
       self.present(alert, animated: true, completion: nil)
    }
    
    func updateView ()
    {
        if  UserDefaultsManager.shared.getUserStatus()
        {
            cardBtm.isHidden = false
            let IfLogedView = Bundle.main.loadNibNamed("IfLogedView", owner: self, options: nil)?.first as! IfLogedView
             IfLogedView.delegate = self
            IfLogedView.ordersTable.reloadData()
            IfLogedView.welcomMssg.text = "Welcom \(UserDefaultsManager.shared.getUserName()!)"
            thisView.addSubview(IfLogedView)
        }
        else {
            cardBtm.isHidden = true
            let ifNotLogin   = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as! View
           ifNotLogin.delegate = self
          thisView.addSubview(ifNotLogin )
        }
        
    }

}


