//
//  ProductDetailsViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var pagecontrolleroutlet: UIPageControl!
    @IBOutlet weak var reviewtable: UITableView!
    @IBOutlet weak var productimgCollection: UICollectionView!
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var loveoutlet: UIButton!
    
    
    
    var product : Products?
    var productimgs : [String]?
    var reviwerImg : [String]?
    var reviewrName : [String]?
    var reviewrcomment : [String]?
    
    
    var timer : Timer?
    var currentCellIndex = 0
    var select: Int = 0
    var viewModel : ShoppingCartViewModel?
    var LineItemToBe : [LineItem]?
    var LineItemObj : LineItem?
    var shopingCardObj : ShoppingCartClass?
    var draftOrder : DraftOrder?
    var drafOrderViewModel : DraftOrderViewModel?
    var shopingCardResponseResult : ShoppingCartResponse?
    var shoppingCartResponseArray = ShoppingCartResponseArray()
    var viewModelProduct = ViewModelProduct()
    var existDraftOrder : ShoppingCartClass?
    
    var productDetailsViewModel : ProductDetailsViewModel?
    var isFav: Bool?
    
    var flag = false
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewWillAppear(_ animated: Bool) {
         self.isFav = self.productDetailsViewModel?.getProductsInFavourites(appDelegate: self.appDelegate, product: &(self.product!))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   print(UserDefaultsManager.shared.getDraftOrderID())
        productDetailsViewModel = ProductDetailsViewModel()
        
      //  UserDefaultsManager.shared.setDraftFlag(draftFlag: true)
        //UserDefaultsManager.shared.setDraftOrderID(draftOrderID: 1111195713817) //<<<<<<
        
        self.isFav = self.productDetailsViewModel?.getProductsInFavourites(appDelegate: self.appDelegate, product: &(self.product!))
        
        drafOrderViewModel = DraftOrderViewModel()
        
        descriptionTextView.text = product?.body_html
        LineItemToBe = []
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        reviwerImg = ["11","22","33"]
        reviewrName = ["sandy","Lara","Youseeif"]
        reviewrcomment = ["it was nice","Not Bad ","it eas awesome"]
        
        pagecontrolleroutlet.numberOfPages = product?.images.count ?? 1
        reviewtable.delegate = self
        reviewtable.dataSource = self
        productTable.delegate = self
        productTable.dataSource = self
        productimgCollection.delegate = self
        productimgCollection.dataSource = self
        productTable.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "productcell")
        reviewtable.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewtablecell")
        
        
        modelling()
        //  UserDefaultsManager.shared.setDraftOrderID(draftOrderID: shopingCardResponseResult?.draft_order?.id )
        
        checkIsFavourite()
        
        
        print(UserDefaultsManager.shared.getDraftOrderID()!)
        
        
        
        
    }
    
    
    @objc func slideToNext()
    {
        if currentCellIndex < (product?.images.count)! - 1
        {
            currentCellIndex += 1
        }
        else
        {
            currentCellIndex = 0
        }
        
        productimgCollection.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right
                                          , animated: true)
        pagecontrolleroutlet.currentPage = currentCellIndex
    }
    func checkIsFavourite() {
        if isFav! {
            loveoutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            loveoutlet.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    @IBAction func lovebtm(_ sender: UIButton) {
        if !UserDefaultsManager.shared.getUserStatus() {
            self.showAlertError(title: "Alert", message: "You must login")
            return
        }
        
        if isFav! {
           
            self.showAlert(title: "deleting !!" , message: "do you want to delete this from favorite ?"){
                self.productDetailsViewModel!.removeProductFromFavourites(appDelegate: self.appDelegate, product: self.product!)
                self.loveoutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            
        } else {
            loveoutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            print( UserDefaultsManager.shared.getUserID()!)
            product?.userId = UserDefaultsManager.shared.getUserID()!
        //    print(  product?.variants![0].id! ?? 20)
            
            productDetailsViewModel!.addProductToFavourites(appDelegate: appDelegate, product: product!)
        }
        isFav = !isFav!
        
        
        
        
    }
    
    
    @IBAction func seeMoreBtm(_ sender: UIButton) {
        
        
        let seemorescreen = self.storyboard?.instantiateViewController(withIdentifier: "seemoreReview") as! SeeMoreReviewsViewController
        
        self.present(seemorescreen, animated: true)
    }
    
    
    
    
    
    
    @IBAction func addToBagbtm(_ sender: UIButton) {
        var existDraftOrder : ShoppingCartClass?
        if !UserDefaultsManager.shared.getUserStatus() {
            self.showAlertError(title: "Alert", message: "You must login")
            return
        }
        else {
            
            let newProducts = fetchFromCoreData()
            if (newProducts.count != 0 ){
                for index in 0...(newProducts.count)-1{
                    if newProducts[index].id == product?.id{
                        self.showToastMessage(message: "This item is already added to the shopping cart", color: .darkText)
                        flag = true
                        break
                    }
                }
            }
            
            
            if !flag{
                addToCoreData(product : product!,userID: UserDefaultsManager.shared.getUserID()!)
                
                if !UserDefaultsManager.shared.getDraftFlag(){ // if false then post
                    postDraftOrder()
                }
                else{   //if true then put on it
                    putToDraftOrder()
                }
            }
            
            
        }
        
    }
    
    func putToDraftOrder(){
        //existDraftOrder = draftorder
        LineItemToBe  = existDraftOrder?.line_items
       // UserDefaultsManager.shared.setDraftOrderID(draftOrderID: draftorder.id)
        LineItemObj = LineItem()
        LineItemObj?.name = self.product?.title
        LineItemObj?.price = self.product?.variants![0].price
        LineItemObj?.sku = self.product?.images[0].src
        LineItemObj?.title = self.product?.title
        //   LineItemObj?.product_id = product?.id
        LineItemObj?.admin_graphql_api_id = ""
        LineItemObj?.grams = self.product?.variants![0].inventory_quantity ?? 0
        LineItemObj?.quantity = 1
        LineItemToBe?.append(LineItemObj!)
        shopingCardObj = ShoppingCartClass(  line_items: LineItemToBe )
        let draftOrder  : ShoppingCartResponse = ShoppingCartResponse(draft_order: shopingCardObj)
        viewModelProduct.callNetworkServiceManagerToPut(draftOrder: draftOrder) { response in
            if response.statusCode >= 200 && response.statusCode <= 299{
                print ("Done")
            }
        }
    }
    
    }
   

extension ProductDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productimgCollection.dequeueReusableCell(withReuseIdentifier: "imagecollectioncell", for: indexPath) as! ProductDetailsImgCollectionViewCell
        cell.productImg.kf.setImage(with: URL(string: product!.images[indexPath.row].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.view.frame.width*0.9,height: self.view.frame.height*0.2)
       
    }
    
    
    
    
    
    
}

extension ProductDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.productTable
        {
            return 1
            
        }
        else {
            return 3
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.productTable
        {
            let cell = productTable.dequeueReusableCell(withIdentifier: "productcell", for: indexPath) as! ProductTableViewCell
            cell.productNameLabel.text = product?.title
            cell.productPriceLabel.text = calcCurrency(price:product!.variants![indexPath.row].price)
            cell.productColor.text = product!.variants?[indexPath.row].option2 ?? "white"
            cell.productSize.text = product!.variants?[indexPath.row].option1 ?? "XL"
            cell.currencyLabel.text = UserDefaultsManager.shared.getCurrency() ?? "EGP"
            //cell.productSize
            return cell
        }
        else {
            let cell = reviewtable.dequeueReusableCell(withIdentifier: "reviewtablecell", for: indexPath) as! ReviewTableViewCell
            cell.reviewLabel.text = reviewrcomment![indexPath.row]
            cell.reviewerImg.image = UIImage(named: reviwerImg![indexPath.row])
            cell.reviwerLabel.text = reviewrName![indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/5-70
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (tableView == reviewtable ) {
            return " Reviews"
        }
        return ""
    }

    
}
extension ProductDetailsViewController {
    func modelling(){
        viewModel = ShoppingCartViewModel()
        let userEmail = UserDefaultsManager.shared.getUserEmail()
        
        let endPoint = "draft_orders.json"
        viewModel?.getDraftOrder(url:getURL(endPoint: endPoint))
        viewModel?.bindResultToViewController = { () in

            self.renderView(shoppingCartResponseArr: self.viewModel?.shoppingCartResponseArray)
        }
    }
    func renderView(shoppingCartResponseArr : ShoppingCartResponseArray?){

        //self.shopingCardResponseResult = self.viewModel?.shoppingCartResponse
        DispatchQueue.main.async {
            guard let response = shoppingCartResponseArr else {return}
            self.shoppingCartResponseArray = response
            for draftorder in self.shoppingCartResponseArray.draft_orders ?? []
            {
                if  draftorder.email == UserDefaultsManager.shared.getUserEmail()
                {
                    self.existDraftOrder = ShoppingCartClass()
                    self.existDraftOrder = draftorder
                    UserDefaultsManager.shared.setDraftFlag(draftFlag: true)
                    UserDefaultsManager.shared.setDraftOrderID(draftOrderID: draftorder.id)
                    print(UserDefaultsManager.shared.getDraftOrderID()!)
                }
            }
            
            
        }



    }
    func postDraftOrder(){
        ///admin/api/2023-01/draft_orders/\(UserDefaultsManager.shared.getUserID()?? "")json
                //let user_id = UserDefaultsManager.shared.getUserID()!
                let user_email = UserDefaultsManager.shared.getUserEmail()!
                let newdraft  : [String : Any] =
               [ "draft_order" :
                    [
             //    "id": user_id  ,
                      "note": "rush order",
                      "email": user_email ,
                      "taxes_included": true,
                      "currency": "USD",
                     
//                      "created_at": "2023-02-13T10:18:48-05:00",
//                      "updated_at": "2023-02-13T10:18:48-05:00",
                      "tax_exempt": false,
                   
                    //  "name": "#D4",
                      "status": "completed",
                      "line_items": [
                        [
                       //   "id": 498266019,
                    //    "variant_id": 39072856,
                      "product_id": 632910392,
                          "title":  self.product?.title ?? "" ,
                        "variant_title": "green",
                      //MARIAM
                        //  "sku": "IPOD2008GREEN",
                      "sku": self.product?.images[0].src ?? "",
                       //"vendor":  self.product?.images[0].src ?? "" ,
                      "vendor":  "" ,
                      //MARIAM
                          "quantity": 1,
                          "requires_shipping": true,
                          "taxable": true,
                          "gift_card": false,
                          "fulfillment_service": "manual",
//                          "grams": 567,
                      "grams": self.product?.variants![0].inventory_quantity! ?? 0,
                          "tax_lines": [],
                     
                          "name": "IPod Nano - 8gb - green",
                          "properties": [],
                          "custom": false,
                          "price": self.product?.variants![0].price ?? "",
                          "admin_graphql_api_id": "gid://shopify/DraftOrderLineItem/498266019"
                       ]
                      ]
                    ]
                ]

        NetworkService.shared.postDraftOrder(url: getURL(endPoint: "draft_orders.json")!, newOrder: newdraft, completion: { data, response, error in
            guard let response = response else {return}
            if response.statusCode >= 200 && response.statusCode <= 299{
                DispatchQueue.main.async {
                    self.modelling()
                }
            }
        })
        
//                NetworkService.shared.postDataToApi(url: getURL(endPoint: "draft_orders.json")!, newOrder: newdraft)
        

        }
    
    func addToCoreData(product : Products, userID : Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let saveToCoreViewModel = CoreDataViewModel()
        saveToCoreViewModel.callManagerToSave(product : product, userID : userID, appDelegate : appDelegate)
        print(userID)
        self.showToastMessage(message: "Item added to shopping cart", color: .darkText)
    }
    
    
    func fetchFromCoreData() -> [Products]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchViewModel = CoreDataViewModel()
        let userID = UserDefaultsManager.shared.getUserID() ?? 0
        let products = fetchViewModel.callManagerToFetch(appDelegate : appDelegate, userID : userID)
        return products ?? []
    }
    
    
    func showToastMessage(message: String, color: UIColor) {
            let toastLabel = UILabel(frame: CGRect(x: view.frame.width / 2 - 120, y: view.frame.height - 130, width: 260, height: 30))

            toastLabel.textAlignment = .center
            toastLabel.backgroundColor = color
            toastLabel.textColor = .white
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true
            toastLabel.text = message
            view.addSubview(toastLabel)

            UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseIn, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
    }
}

