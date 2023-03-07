//
//  ShoppingCartViewController.swift
//  ShopifyProj
//
//  Created by Mariam Moataz on 20/02/2023.
//

import UIKit
import Reachability

class ShoppingCartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    var lineItems : [LineItem]?
    var products : [Products]?
    var shoppingCart : ShoppingCartResponse?
    var shoppingCartViewModel = ShoppingCartViewModel()
    var index : Int?
    var network : Reachability!
    var viewModel : CoreDataViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        network = Reachability.forInternetConnection()
        viewModel = CoreDataViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if !network.isReachable(){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            products = viewModel.callManagerToFetch(appDelegate: appDelegate, userID: UserDefaultsManager.shared.getUserID()!)
            tableView.reloadData()
        }
        else{
            getDraftOrders()
        }
        
    }
    
    
    @IBAction func checkoutBtn(_ sender: Any) {
        let paymentController = self.storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        paymentController.lineItems = []
        paymentController.lineItems = lineItems
    }
    
    func renderDraftOrders(shoppingCart : ShoppingCartResponse?){
        self.shoppingCart?.draft_order = shoppingCart?.draft_order
        self.lineItems = shoppingCart?.draft_order?.line_items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}

extension ShoppingCartViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !network.isReachable(){
            return products?.count ?? 0
        }
        return lineItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ShoppingCartTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingCartTableViewCell
        cell.view = self.view
        cell.viewVC = self
        if !network.isReachable(){
            cell.productTitle.text = products?[indexPath.section].title
            cell.productPrice.text = products?[indexPath.section].variants?[0].price
            cell.numOfItems.text = String(1)
            cell.productImg.kf.setImage(with: URL(string: products?[indexPath.section].images[0].src ?? "load"),placeholder: UIImage(named: "load"))
        }
        else{
            cell.lineItem = LineItem()
            cell.lineItem = lineItems?[indexPath.section]
            cell.productTitle.text = lineItems?[indexPath.section].title
            cell.productPrice.text = lineItems?[indexPath.section].price
            cell.numOfItems.text = String(lineItems?[indexPath.section].quantity ?? 0)
            print(lineItems?[indexPath.section].sku ?? "")
            cell.productImg.kf.setImage(with: URL(string: lineItems?[indexPath.section].sku ?? "load"),placeholder: UIImage(named: "load"))
        }
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
            if !network.isReachable(){
                deleteItem(indexPath: indexPath)
            }
            else{
                lineItems?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        }
    }
    
}


extension ShoppingCartViewController{
    
    func deleteItem(indexPath : IndexPath){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        viewModel.callManagerToDelete(appDelegate: appDelegate,productID: (products?[indexPath.section].id)!, userID: UserDefaultsManager.shared.getUserID()!)
            products?.remove(at: indexPath.section)
            let indexSet = NSMutableIndexSet()
            indexSet.add(indexPath.section)
            tableView.deleteSections(indexSet as IndexSet, with: .fade)
            tableView.reloadData()
    }
    
    func getDraftOrders(){
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.center = view.center
            view.addSubview(indicator)
            indicator.startAnimating()
            let userEmail = UserDefaultsManager.shared.getUserEmail()
            //let endPoint = "draft_orders/1110937436441.json?email=\(userEmail ?? "")"
        let endPoint = "draft_orders/1110846079257.json"
            shoppingCartViewModel.getOneDraftOrder(url: getURL(endPoint: endPoint))
            shoppingCartViewModel.bindResultToViewController = {
                self.renderDraftOrders(shoppingCart: self.shoppingCartViewModel.shoppingCartResponse)
                indicator.stopAnimating()
            }

    }
}
