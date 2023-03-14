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
    
    
    @IBOutlet weak var proceedToCheckout: UIButton!
    
    var lineItems : [LineItem]?
    var products : [Products]?
    static var shoppingCart : ShoppingCartResponse?
    var shoppingCartViewModel = ShoppingCartViewModel()
    var index : Int?
    var network : Reachability!
    var viewModel : CoreDataViewModel!
    var viewModelProduct = ViewModelProduct()
    var subTotal : Float!
    var price : String!
    var counter = 0
    var networkFlag = false
    var tempIndexPath : IndexPath  = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        network = Reachability.forInternetConnection()
        viewModel = CoreDataViewModel()
        self.navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc func back(sender: UIBarButtonItem){
        let alert = UIAlertController(title: "Alert", message: "Do you want to save the changes before proceeding with this action?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default){ _ in
            self.putInDraftOrder()
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(UIAlertAction(title: "No", style: .default){ _ in
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        subTotal = 0
        price = "0"
        
        //UserDefaultsManager.shared.setDraftOrderID(draftOrderID: 1111195713817)
        //print(UserDefaultsManager.shared.getDraftOrderID())
        //checkAccessability()
        //UserDefaultsManager.shared.setCurrency(currency: "EGP")
        
        if UserDefaultsManager.shared.getUserID() == nil || UserDefaultsManager.shared.getUserID() == 0{
            let alert = UIAlertController(title: "Login", message: "You can't view the shopping cart if you are not logged in ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default){ _ in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true)
        }

        else if UserDefaultsManager.shared.getDraftOrderID() == nil || UserDefaultsManager.shared.getDraftOrderID() == 0{
            let alert = UIAlertController(title: "No items added", message: "You didn't add any items in the shoppingCart ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default){ _ in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true)
        }
        
        else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            products = viewModel.callManagerToFetch(appDelegate: appDelegate, userID: UserDefaultsManager.shared.getUserID()!)
            if network.isReachable(){
                getDraftOrders()
            }
            
            
            if !network.isReachable(){
                networkFlag = true
                proceedToCheckout.isEnabled = false
            }
            else{
                networkFlag = false
                proceedToCheckout.isEnabled = true
            }
            tableView.reloadData()
        }
        
        
    }
    
    
    @IBAction func checkoutBtn(_ sender: Any) {
        AddressViewController.flag = false
        PaymentViewController.lineItems = []
        PaymentViewController.lineItems = lineItems
        PaymentViewController.subTotal = 0.0
        subTotal = Float(subTotalLabel.text ?? "")
        PaymentViewController.subTotal = subTotal
        putInDraftOrder()
    }
    
    func renderDraftOrders(shoppingCart : ShoppingCartResponse?){

        DispatchQueue.main.async {
            guard let shoppingCart = shoppingCart else {return}
            ShoppingCartViewController.shoppingCart = shoppingCart
            //ShoppingCartViewController.shoppingCart?.draft_order = shoppingCart.draft_order
            self.lineItems = shoppingCart.draft_order?.line_items
            
            
//            for index in 0...(self.lineItems?.count ?? 0) - 1{
//                let price = self.lineItems?[index].price ?? ""
//                self.lineItems?[index].price = calcCurrency(price: price)
//            }
            self.tableView.reloadData()
            self.calcSubTotalInc()
            
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
        
        if !networkFlag{
            cell.setNum()
        }
        
        
        if !network.isReachable(){      //get from coreData
            cell.productTitle.text = products?[indexPath.row].title
            cell.productPrice.text = products?[indexPath.row].variants?[0].price
            cell.numOfItems.text = String(1)
            cell.num = Int(cell.numOfItems.text ?? "") ?? 0
            cell.productImg.kf.setImage(with: URL(string: products?[indexPath.row].images[0].src ?? "load"),placeholder: UIImage(named: "load"))
        }
        else{
            
            //cell.currencyLabel.text = setCurrencyLabel()
            //cell.productPrice.text = calcCurrency(price: lineItems?[indexPath.row].price ?? "")
            let price = lineItems?[indexPath.row].price
            cell.productPrice.text = calcCurrency(price: price ?? "")
            //lineItems?[indexPath.row].price = calcCurrency(price : price)
            cell.productPrice.text?.append(contentsOf: " \(setCurrencyLabel()) /item")
            cell.productTitle.text = lineItems?[indexPath.row].title
            //cell.productPrice.text = lineItems?[indexPath.row].price
            cell.numOfItems.text = String(lineItems?[indexPath.row].quantity ?? 0)
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
            tempIndexPath = indexPath
            deleteItemFromCoreData(indexPath : tempIndexPath)
            deleteFromAPi(indexPath: tempIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
        let pdVC = thirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        pdVC.product = Products()
        pdVC.product?.id = lineItems?[indexPath.row].id ?? 0
        pdVC.product?.title = lineItems?[indexPath.row].title ?? ""
        pdVC.product?.variants?[0].price = lineItems?[indexPath.row].price
        pdVC.product?.images[0].src = lineItems?[indexPath.row].sku
        self.navigationController?.pushViewController(pdVC, animated: true)
    }
    
}


extension ShoppingCartViewController{
    
    func deleteItemFromCoreData(indexPath : IndexPath){
        if network.isReachable(){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            viewModel.callManagerToDelete(appDelegate: appDelegate,productID: products?[indexPath.row].id ?? 0, userID: UserDefaultsManager.shared.getUserID()!)
                products?.remove(at: indexPath.row)
                //tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                //tableView.reloadData()
        }
    }
    
    func getDraftOrders(){
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.center = view.center
            view.addSubview(indicator)
            indicator.startAnimating()
            let draftOrder = UserDefaultsManager.shared.getDraftOrderID()
            let endPoint = "draft_orders/\(draftOrder!).json"
            shoppingCartViewModel.getOneDraftOrder(url: getURL(endPoint: endPoint))
            shoppingCartViewModel.bindResultToViewController = {
                self.renderDraftOrders(shoppingCart: self.shoppingCartViewModel.shoppingCartResponse)
                indicator.stopAnimating()
            }
    }
    
    func putInDraftOrder(){
        var newDraftOrder = ShoppingCartViewController.shoppingCart?.draft_order
        let updatedLineItems = self.lineItems
        newDraftOrder?.line_items = updatedLineItems
        let updateCartVM = ViewModelProduct()
        let draftOrderResponse = ShoppingCartResponse(draft_order: newDraftOrder)
        updateCartVM.callNetworkServiceManagerToPut(draftOrder: draftOrderResponse) { response in
            if response.statusCode >= 200 && response.statusCode <= 299{
                print ("Cart Put done Succefully")
            }
        }
    }

    
    func checkAccessability(){
        if UserDefaultsManager.shared.getUserID() == nil || UserDefaultsManager.shared.getUserID() == 0{
            let alert = UIAlertController(title: "Login", message: "You can't view the shopping cart if you are not logged in ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default){ _ in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true)
        }
        
        else if UserDefaultsManager.shared.getDraftOrderID() == nil || UserDefaultsManager.shared.getDraftOrderID() == 0{
            let alert = UIAlertController(title: "No items added", message: "You didn't add any items in the shoppingCart ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default){ _ in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true)
        }
        else{
            return
        }
    }
    
    func deleteFromAPi(indexPath : IndexPath){
        
        if lineItems?.count == 1{
            let alert = UIAlertController(title: "Remove Product", message: "Are you sure you want to delete this product?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default){_ in
                self.lineItems?.remove(at: indexPath.row)
                let draftOrderId = UserDefaultsManager.shared.getDraftOrderID() ?? 0
                let endpoint = "draft_orders/\(draftOrderId).json"
                self.shoppingCartViewModel.deleteDraftOrder(url: endpoint)
                DispatchQueue.main.async {
                    UserDefaultsManager.shared.setDraftFlag(draftFlag: false)
                    UserDefaultsManager.shared.setDraftOrderID(draftOrderID: nil)
                    self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                    self.tableView.reloadData()
                    self.subTotalLabel.text = ""
                }
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .default){_ in
            })
            self.present(alert, animated: true)
            
        }
        
        else{
            let alert = UIAlertController(title: "Remove Product", message: "Are you sure you want to delete this product?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default){_ in
                if !self.network.isReachable(){
                    //self.deleteItem(indexPath: indexPath)
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

extension ShoppingCartViewController : ShoppingCartDelegate{
    func calcSubTotalInc(){
        subTotal = 0
        for index in 0...(lineItems?.count ?? 0) - 1{
            let price1 = (Float(lineItems?[index].price ?? "") ?? 0.0) * (Float(lineItems?[index].quantity ?? 0))
            subTotal += price1
        }
        let totalInCurrency = calcCurrency(price: String(subTotal))
        subTotalLabel.text = totalInCurrency
       // subTotalLabel.text = String(format: "%.2f", subTotal)
    }
    
    func calcSubTotalDec(price: String) {
        let price1 = Float(price) ?? 0.0
        subTotal -= price1
        //subTotalLabel.text = String(format: "%.2f", subTotal)
        let totalInCurrency = calcCurrency(price: String(subTotal))
        subTotalLabel.text = totalInCurrency
        //subTotalLabel.text = String(format: "%.2f", totalInCurrency)
        //subTotalLabel.text = String(format: "%.2f", subTotal)
    }
    
    func setLineItems(lineItem : LineItem, index : Int){
        self.lineItems?[index].quantity = lineItem.quantity
    }
    
    func deleteFromCart(indexPath : IndexPath){
        tempIndexPath = indexPath
        deleteItemFromCoreData(indexPath : tempIndexPath)
        deleteFromAPi(indexPath: indexPath)
    }
    
}
