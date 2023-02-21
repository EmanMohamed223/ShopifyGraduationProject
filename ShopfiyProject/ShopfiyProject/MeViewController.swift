//
//  MeViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 21/02/2023.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var welcomeOrAskingLabel: UILabel!
    @IBOutlet weak var ordersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ordersTable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ordercell")
    }
    
    @IBAction func moreOrderBtn(_ sender: UIButton) {
        var seemoreOrders = self.storyboard?.instantiateViewController(withIdentifier: "seemore") as! MoreOrdersViewController
         
         self.present(seemoreOrders, animated: true)
        
    }
    @IBAction func MoreWishListBtn(_ sender:UIButton) {
        var seemoreWishList = self.storyboard?.instantiateViewController(withIdentifier: "seemore") as! WishListViewController
         
         self.present(seemoreWishList, animated: true)
    }
    
   

}
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4-40
    }
    
}
