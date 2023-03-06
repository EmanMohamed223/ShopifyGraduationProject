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
    
    var lineItems : [LineItem]?
    var products : [Products]?
    var shoppingCart : ShoppingCartResponse?
    var shoppingCartViewModel = ShoppingCartViewModel()
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        let userEmail = UserDefaultsManager.shared.getUserEmail()
        //let endPoint = "draft_orders.json?email=\(userEmail ?? "")"
        let endPoint = "draft_orders/1110846079257.json?email=\(userEmail ?? "")"
        shoppingCartViewModel.getDraftOrder(url: getURL(endPoint: endPoint))
        shoppingCartViewModel.bindResultToViewController = {
            self.renderDraftOrders(shoppingCart: self.shoppingCartViewModel.shoppingCartResponse)
            indicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        let viewModel = CoreDataViewModel()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        products = viewModel.callManagerToFetch(appDelegate: appDelegate, userID: UserDefaultsManager.shared.getUserID()!)
    }
    
    
    @IBAction func checkoutBtn(_ sender: Any) {
    }
    
    func renderDraftOrders(shoppingCart : ShoppingCartResponse?){
        self.shoppingCart?.draftOrder = shoppingCart?.draftOrder
        self.lineItems = shoppingCart?.draftOrder?.line_items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}

extension ShoppingCartViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return lineItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ShoppingCartTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingCartTableViewCell
        cell.productTitle.text = lineItems?[indexPath.row].title
        cell.productPrice.text = lineItems?[indexPath.row].price
        cell.numOfItems.text = String(lineItems?[indexPath.row].quantity ?? 0)
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
            lineItems?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}


extension ShoppingCartViewController : ShoppingCartDelegate{
    func getItemNumbers() -> (Int)?{
        return 2
    }
    
    
}
