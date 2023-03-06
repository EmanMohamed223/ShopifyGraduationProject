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
    var shopingCardResponse : ShoppingCartResponse?
    var drafOrderViewModel : DraftOrderViewModel?
    var shopingCardResponseResult : ShoppingCartResponse?
    
    
    
    
    var productDetailsViewModel : ProductDetailsViewModel?
    var isFav: Bool?

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    productDetailsViewModel = ProductDetailsViewModel()
       
        
        
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
        
        checkIsFavourite()
        
        
        
        
        
        
        
       
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
            loveoutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            productDetailsViewModel!.removeProductFromFavourites(appDelegate: appDelegate, product: product!)
        } else {
            loveoutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            print( UserDefaultsManager.shared.getUserID()!)
            product?.variants![0].id = UserDefaultsManager.shared.getUserID()!
            print(  product?.variants![0].id! ?? 20)

            productDetailsViewModel!.addProductToFavourites(appDelegate: appDelegate, product: product!)
        }
        isFav = !isFav!
        
        
        
        
    }
    
    
    @IBAction func seeMoreBtm(_ sender: UIButton) {
        
        
        let seemorescreen = self.storyboard?.instantiateViewController(withIdentifier: "seemoreReview") as! SeeMoreReviewsViewController
        
        self.present(seemorescreen, animated: true)
    }
    
    
    
    
    
  
    @IBAction func addToBagbtm(_ sender: UIButton) {
        if !UserDefaultsManager.shared.getUserStatus() {
            self.showAlertError(title: "Alert", message: "You must login")
            return
        }
        else {
            
            addToCoreData(product : product!,userID: UserDefaultsManager.shared.getUserID()!)
           postOrder()
        }
        //       // if ((shopingCardResponseResult?.draft_orders?.isEmpty) != nil) {
        //            LineItemObj = LineItem()
        //            LineItemObj?.name = self.product?.title
        //            LineItemObj?.price = self.product?.variants![0].price
        //            LineItemObj?.vendor = self.product?.images[0].src
        //            LineItemToBe?.append(LineItemObj!)
        //            shopingCardObj = ShoppingCartClass(id : UserDefaultsManager.shared.getUserID()! , name : UserDefaultsManager.shared.getUserName()! , email : UserDefaultsManager.shared.getUserEmail()! , line_items: LineItemToBe)
        //            let draftOrder = DraftOrder(draft_orders: shopingCardObj!)
        ////            shopingCardResponse = ShoppingCartResponse(draft_orders: shopingcardarray )
        //                    drafOrderViewModel?.createNewDraft(newDraftOrder: draftOrder) { data, response, error in
        //
        //                        guard error == nil else {
        //                             DispatchQueue.main.async {
        //                                 self.showAlertError(title: "Couldnot add this product", message: "Please, try again later.")
        //                             }
        //                             return
        //                         }
        //
        //                         guard response?.statusCode != 422 else {
        //                             DispatchQueue.main.async {
        //                                 self.showAlertError(title: "Couldnot add", message: "Please, try another time.")
        //                             }
        //                             return
        //                         }
        //
        //                         print("added successfully")
        //
        //
        //                     }
        //
        //        //}
        //
        //
        //
        //
        //
        //
        //    }
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
            cell.productPriceLabel.text = product!.variants![indexPath.row].price
            cell.productColor.text = product!.variants?[indexPath.row].option2 ?? "white"
            cell.productSize.text = product!.variants?[indexPath.row].option1 ?? "XL"
            
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
        viewModel?.getDraftOrder(url: "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json")
        viewModel?.bindResultToViewController = { () in

            self.renderView()
        }
    }
    func renderView(){

            self.shopingCardResponseResult = self.viewModel?.shoppingCartResponse
//       self.LineItemtobe = (self.shopingCardArray?.shoppingCart?.line_items)!
 //     print (LineItemtobe!.count)


    }
    func postOrder(){
    ///admin/api/2023-01/draft_orders/\(UserDefaultsManager.shared.getUserID()?? "")json
            let user_id = UserDefaultsManager.shared.getUserID()!
            let user_email = UserDefaultsManager.shared.getUserEmail()!
            let newdraft  : [String : Any] =
           [ "draft_order" :
                [
                  //"id": user_id  ,//
                  "note": "rush order",
                  "email": user_email ,
                  "taxes_included": true,
                  "currency": "USD",
                 
                  "created_at": "2023-02-13T10:18:48-05:00",
                  "updated_at": "2023-02-13T10:18:48-05:00",
                  "tax_exempt": false,
               
                  "name": "#D4",
                  "status": "completed",
                  "line_items": [
                    [
                      "id": 498266019,
     //                 "variant_id": 39072856,
                      "product_id": self.product?.id ?? 0,
                      "title":  self.product?.title ?? "" ,
                      "variant_title": "green",
                      "sku": "IPOD2008GREEN",
                      "vendor":  self.product?.images[0].src ?? "" ,
                      "quantity": 2,
                      "requires_shipping": true,
                      "taxable": true,
                      "gift_card": false,
                      "fulfillment_service": "manual",
                      "grams": 567,
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

            NetworkService.shared.postDataToApi(url: getURL(endPoint: "draft_orders.json")!, newOrder: newdraft)

        }
    
    func addToCoreData(product : Products,userID : Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let saveToCoreViewModel = CoreDataViewModel()
        saveToCoreViewModel.callManagerToSave(product : product, userID : userID, appDelegate : appDelegate)
        showToastMessage(message: "Item added to shopping cart", color: .darkText)
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

