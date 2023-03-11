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
    var viewModelProduct = ViewModelProduct()
    var subTotal : Float!
    var price : String!
    var counter = 0
    //var quantityArr : Int = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = false
        network = Reachability.forInternetConnection()
        viewModel = CoreDataViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        subTotal = 0
        price = "0"
        if !network.isReachable(){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            products = viewModel.callManagerToFetch(appDelegate: appDelegate, userID: UserDefaultsManager.shared.getUserID()!)
            tableView.reloadData()
        }
        else{
            getDraftOrders()
        }
        tableView.reloadData()
    }
    
    
    @IBAction func checkoutBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addressVC") as! AddressViewController
        vc.flag = true
        PaymentViewController.lineItems = []
        PaymentViewController.lineItems = lineItems
        PaymentViewController.subTotal = 0.0
        PaymentViewController.subTotal = subTotal
    }
    
    func renderDraftOrders(shoppingCart : ShoppingCartResponse?){
        guard let shoppingCart = shoppingCart else {return}
        self.shoppingCart?.draft_order = shoppingCart.draft_order
        self.lineItems = shoppingCart.draft_order?.line_items
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.calcSubTotalInc()
            //self.subTotalLabel.text = String(format: "%.2f", self.subTotal)
        }
        
    }
    
}

extension ShoppingCartViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !network.isReachable(){
            return products?.count ?? 0
        }
        return lineItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ShoppingCartTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingCartTableViewCell
        
        cell.view = self.view
        cell.viewVC = self
        cell.tableVC = tableView
        cell.delegate = self
        cell.indexPath = indexPath
        cell.lineItems = []
        cell.lineItems = lineItems ?? []
        
        if !network.isReachable(){      //get from coreData
            cell.productTitle.text = products?[indexPath.row].title
            cell.productPrice.text = products?[indexPath.row].variants?[0].price
            cell.numOfItems.text = String(1)
            cell.num = Int(cell.numOfItems.text ?? "") ?? 0
            cell.productImg.kf.setImage(with: URL(string: products?[indexPath.row].images[0].src ?? "load"),placeholder: UIImage(named: "load"))
        }
        else{
            
            cell.productTitle.text = lineItems?[indexPath.row].title
            cell.productPrice.text = lineItems?[indexPath.row].price
            cell.numOfItems.text = String(1)
            cell.productImg.kf.setImage(with: URL(string: lineItems?[indexPath.row].sku ?? "load"),placeholder: UIImage(named: "load"))
            cell.priceQ = [indexPath.row : lineItems?[indexPath.row].quantity ?? 1]
        }
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Remove Product", message: "Are you sure you want ot delete this product?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default){_ in
                if !self.network.isReachable(){
                    self.deleteItem(indexPath: indexPath)
                }
                else{
                    self.lineItems?.remove(at: indexPath.row)
                    let updatedLineItems = ShoppingCartClass(line_items: self.lineItems)
                    let draftOrder = ShoppingCartResponse(draft_order: updatedLineItems)
                    self.viewModelProduct.callNetworkServiceManagerToPut(draftOrder: draftOrder) { response in
                        if response.statusCode >= 200 && response.statusCode <= 299{
                            DispatchQueue.main.async {
                                
                                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                                self.calcSubTotalInc()
                            }
                        }
                    }
                }
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .default){_ in
            })
            self.present(alert, animated: true)
            
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
            tableView.deleteSections(indexSet as IndexSet, with: .automatic)
            tableView.reloadData()
    }
    
    func getDraftOrders(){
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.center = view.center
            view.addSubview(indicator)
            indicator.startAnimating()
            let draftOrder = UserDefaultsManager.shared.getDraftOrderID()
            let endPoint = "draft_orders/\(draftOrder ?? 0).json"
            shoppingCartViewModel.getOneDraftOrder(url: getURL(endPoint: endPoint))
            shoppingCartViewModel.bindResultToViewController = {
                self.renderDraftOrders(shoppingCart: self.shoppingCartViewModel.shoppingCartResponse)
                indicator.stopAnimating()
            }
    }
    
    func calcSubTotalAgain(price : String, quantity : String?){
        let price1 = Float(price) ?? 0.0
        subTotal += price1
        subTotalLabel.text = String(format: "%.2f", subTotal)
    }
}

extension ShoppingCartViewController : ShoppingCartDelegate{
    func calcSubTotalInc(){
        subTotal = 0
        for index in 0...(lineItems?.count ?? 0) - 1{
            let price1 = (Float(lineItems?[index].price ?? "") ?? 0.0) * (Float(lineItems?[index].quantity ?? 0))
            subTotal += price1
        }
        subTotalLabel.text = String(format: "%.2f", subTotal)
    }
    
    func calcSubTotalDec(price: String) {
        let price1 = Float(price) ?? 0.0
        subTotal -= price1
        subTotalLabel.text = String(format: "%.2f", subTotal)
    }
    
    func setLineItems(lineItem : LineItem, index : Int){
        self.lineItems?[index].quantity = lineItem.quantity
    }
    
    func editInDraftOrder(){
        
    }
    
}
