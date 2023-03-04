//
//  ShoppingCartViewController.swift
//  ShopifyProj
//
//  Created by Mariam Moataz on 20/02/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    var draftOrders : [LineItem]?
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func checkoutBtn(_ sender: Any) {
    }
    
    func renderDraftOrders(shoppingCart : ShoppingCart?){
        guard let shoppingCart = shoppingCart else { return}
      //  self.draftOrders = shoppingCart.line_items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}

extension ShoppingCartViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return draftOrders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ShoppingCartTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingCartTableViewCell
        cell.productTitle.text = draftOrders?[indexPath.row].title
        cell.productPrice.text = draftOrders?[indexPath.row].price
        cell.numOfItems.text = String(draftOrders?[indexPath.row].quantity ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : UIView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            draftOrders?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}


extension ShoppingCartViewController : ShoppingCartDelegate{
    func getItemNumbers() -> (Int)?{
        return 2
    }
    
    
}
