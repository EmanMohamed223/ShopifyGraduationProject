//
//  CategoryViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 01/12/1401 AP.
//

import UIKit
import Floaty
import SnackBar_swift
class CategoryViewController: UIViewController {

    @IBOutlet weak var favCategoryBtn: UIButton!
    @IBOutlet weak var categoryCartBtn: UIButton!
    @IBOutlet weak var categorySearch: UIButton!
    @IBOutlet weak var FloatButton: Floaty!
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var categorySegmented: UISegmentedControl!
    var subFlag : String = ""
    var mainFlag : Int = 0
    var viewModel : ViewModelProduct?
    var CategoryProductsURL : String?
    var productArray : ResponseProducts?
    var filterArray : ResponseProducts?
    var flag : Bool = false
    var isFav : Bool?
    var productDetailsViewModel : ProductDetailsViewModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var productFavViewModel = ProductFavViewModel()
    override func viewWillAppear(_ animated: Bool) {
//        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
//        self.CategoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
        self.tabBarController?.tabBar.isHidden = false
       self.CategoryCollectionView.reloadData()
        self.tabBarController?.tabBar.isHidden = false

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetailsViewModel = ProductDetailsViewModel()

       
        // Do any additional setup after loading the view.
      
        let nib = UINib(nibName: "CategoryViewCell", bundle: nil)
        self.CategoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
        categorySegmented.selectedSegmentIndex = 0
        selectSubCategory()
        categorySearch.addTarget(self, action: #selector(TapSearch), for: .touchUpInside)
        categoryCartBtn.addTarget(self, action: #selector(TapCart), for: .touchUpInside)
        favCategoryBtn.addTarget(self, action: #selector(Tapfavourite), for: .touchUpInside)
        CategoryProductsURL = getURL(endPoint: "products.json")
        modelling(newUrl: chooseMainCategory (index : 0))
        self.CategoryCollectionView.reloadData()
    }

    @IBAction func selectedSegment(_ sender: Any) {
       
        switch categorySegmented.selectedSegmentIndex {
       
        case 0:
            if (flag){
                modelling(newUrl: chooseMainCategory (index :  0) + subFlag)
            }
            else{
                modelling(newUrl: chooseMainCategory (index :  0))
            }
            mainFlag = 0
            self.CategoryCollectionView.reloadData()
          
        case 1 :
            if (flag){
                modelling(newUrl: chooseMainCategory (index :  1) + subFlag)
            }
            else{
                
                modelling(newUrl: chooseMainCategory (index :  1))
            }
            mainFlag = 1
          
            self.CategoryCollectionView.reloadData()
            
        case 2:
            if (flag){
                modelling(newUrl: chooseMainCategory (index :  2) + subFlag)
            }
            else{
                
                modelling(newUrl:chooseMainCategory (index : 2))
            }
            mainFlag = 2
    
            self.CategoryCollectionView.reloadData()
             
        case 3:
            if (flag){
                modelling(newUrl: chooseMainCategory (index :  3) + subFlag)
            }
            else{
                
                modelling(newUrl:chooseMainCategory (index : 3))
            }
            mainFlag = 3
          
            self.CategoryCollectionView.reloadData()
             default:
                 break
     
        }
    
    }
}
extension CategoryViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
        cell.cornerRadius = CGFloat(20)
        cell.productDelegate = self
        var productToPass  = self.productArray?.products[indexPath.row]
        self.isFav = self.productDetailsViewModel?.getProductsInFavourites(appDelegate: self.appDelegate, product: &(productToPass)!)

      cell.Currency.text = UserDefaultsManager.shared.getCurrency()

        cell.checkFavourite(isFav: self.isFav!, product: productToPass!)
    
        cell.categoryLabel.text = productArray?.products[indexPath.row].title
        cell.categoryLabel.adjustsFontSizeToFitWidth = true
        cell.CategoryImage.kf.setImage(with: URL(string: productArray?.products[indexPath.row].images[0].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)

        cell.categoryPrice.text = calcCurrency(price: productArray?.products[indexPath.row].variants![0].price)
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         return   CGSize(width: (collectionView.frame.size.width/2)-22 , height: (collectionView.frame.size.height/3)-20 )
            


         }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
       let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
        let productDetailsView = ThirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
          productDetailsView.product = productArray?.products[indexPath.row]
        self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
extension CategoryViewController {
    func modelling(newUrl : String?){
        viewModel = ViewModelProduct()
        viewModel?.getProducts(url: CategoryProductsURL?.appending(newUrl ?? ""))
        viewModel?.bindResultToViewController = { () in
            
            self.renderView()
        }
    }
    func renderView(){
        DispatchQueue.main.async {
            self.productArray = self.viewModel?.resultProducts
          self.filterArray = self.productArray
            self.CategoryCollectionView.reloadData()
         
            if(self.productArray?.products.count ?? 0 < 1){
                SnackBar.make(in: self.view, message: "No Items Available Now !", duration: .lengthLong ).show()
            }
        }
    }
    func selectSubCategory(){
        
        FloatButton.addItem( icon: UIImage(systemName: "tshirt.fill")!) {  FloatyItem in
        
            self.modelling(newUrl: chooseMainCategory (index : self.mainFlag) + chooseSubCategory(index: 0))
            self.subFlag = chooseSubCategory(index: 0)
            self.flag = true
            self.CategoryCollectionView.reloadData()
            
      }
        FloatButton.addItem( icon: UIImage(named: "access")! ) { [self] FloatyItem in
            
            self.modelling(newUrl: chooseMainCategory (index : mainFlag) + chooseSubCategory(index: 1))
            self.subFlag = chooseSubCategory(index: 1)
            self.flag = true
            self.CategoryCollectionView.reloadData()
        }
        FloatButton.addItem( icon: UIImage(systemName: "shoeprints.fill")!) { [self] FloatyItem in
       
            self.modelling(newUrl: chooseMainCategory (index : mainFlag) + chooseSubCategory(index: 2))
            self.subFlag = chooseSubCategory(index: 2)
            self.flag = true
            self.CategoryCollectionView.reloadData()
        }
        FloatButton.addItem( icon: UIImage(named: "cro")!) { FloatyItem in
            
            self.modelling(newUrl: chooseMainCategory (index : 0))
            self.subFlag = ""
            self.flag = true
            self.CategoryCollectionView.reloadData()
        }
    }
    @objc func TapSearch(){
        let view =  self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
      
      
        view.productPriceArray = productArray?.products
        view.data(flag: 2)
        self.navigationController?.pushViewController(view, animated: true)
    }
    @objc func Tapfavourite(){
        if UserDefaultsManager.shared.getUserID() != 0   {
            let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
            let view = ThirdStoryBoard.instantiateViewController(withIdentifier: "favorite") as! WishListViewController
            
            self.navigationController?.pushViewController(view, animated: true)
        }
        else {
            let alert = UIAlertController(title: "You Should Log In First", message: "Please Log In To Could add To Your Favourites", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        }
        @objc func TapCart(){
            if UserDefaultsManager.shared.getUserID() != 0   {
                let SecondStoryBoard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
                let view = SecondStoryBoard.instantiateViewController(withIdentifier: "secondStoryboard1") as! ShoppingCartViewController
                self.navigationController?.pushViewController(view, animated: true)
            }
            
            else {
                let alert = UIAlertController(title: "You Should Log In First", message: "Please Log In To Could add To Your Cart", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }}
extension CategoryViewController : FireActionInCategoryCellProtocol
{
    func showAlertdelet(title:String, message:String, complition:@escaping ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "OK", style: .destructive) { _ in
            complition()
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    func addFavourite(appDelegate: AppDelegate, product: Products) {
        productFavViewModel.addFavourite(appDelegate: appDelegate, product: product)
    }
    
    func deleteFavourite(appDelegate: AppDelegate, product: Products) {
        productFavViewModel.deleteFavourite(appDelegate: appDelegate, product: product)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let Action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(Action)
        self.present(alert, animated: true, completion: nil)
    }
}
