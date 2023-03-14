//
//  BrandDetailsViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 02/12/1401 AP.
//

import UIKit
import Kingfisher
import SnackBar_swift
//import MaterialComponents.MaterialSlider
class SearchViewController: UIViewController {

   
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var brandDetailsCollectionView: UICollectionView!

    
    var flagCatgory : Int = 0
    var priceFilter : Int = 0
    var brandProducts : [Products]?
    var BrandDetailsURL : String?
    var brandName : String?
    var brandID : Int?
    var viewModel : ViewModelProduct?
    var productPriceArray : [Products]?
    var productBSArray : [Products]?
    var productFavViewModel = ProductFavViewModel()
    var isFav : Bool?
    var productDetailsViewModel : ProductDetailsViewModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewWillAppear(_ animated: Bool) {
//        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
//        self.brandDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
//        subView.isHidden = true
       self.brandDetailsCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetailsViewModel = ProductDetailsViewModel()

        self.title = brandName ?? ""
        let nib = UINib(nibName: "CategoryViewCell", bundle: nil)
        self.brandDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
        subView.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
   
        self.brandDetailsCollectionView.reloadData()
        searchbar.delegate = self
    }
   
    @IBAction func cancelbtn(_ sender: Any) {
        subView.isHidden = true
 
        productPriceArray = productPriceArray!.sorted { $0.title < $1.title }
        self.brandDetailsCollectionView.reloadData()
        
    }
    @IBAction func selectZtoA(_ sender: Any) {
        if( productPriceArray!.count > 1 || (brandProducts?.count)! > 1 ){
            subView.isHidden = true
            productPriceArray = productPriceArray!.sorted { $0.title > $1.title }
            //  productPriceArray = brandProducts
            self.brandDetailsCollectionView.reloadData()
            
        }
        else{
            
            SnackBar.make(in: self.view, message: "You Have one Item !", duration: .lengthLong ).show()
        }
    }
    
    @IBAction func selectPrice(_ sender: Any) {
        if(productPriceArray!.count > 1 || (brandProducts?.count)! > 1){
       
            subView.isHidden = false
    
        }
        else{
            
            SnackBar.make(in: self.view, message: "You Have one Item !", duration: .lengthLong ).show()
        }
        }
    @IBAction func slider(_ sender: UISlider) {
      
        productPriceArray = brandProducts!.filter({ Products in
            Double( Products.variants?[0].price ?? "0")! < Double(sender.value)
          
        })
      
                self.brandDetailsCollectionView.reloadData()
    }

}
extension SearchViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productPriceArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         
                  
        return   CGSize(width: (collectionView.frame.size.width/2)-22 , height: (collectionView.frame.size.height/3)-20 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
        cell.productDelegate = self
        var productToPass  = self.productPriceArray?[indexPath.row]
        self.isFav = self.productDetailsViewModel?.getProductsInFavourites(appDelegate: self.appDelegate, product: &(productToPass)!)
        cell.checkFavourite(isFav: self.isFav!, product: productToPass!)

        cell.categoryLabel.text = productPriceArray?[indexPath.row].title
        //   cell.currency.text = UserDefaultsManager.shared.getCurrency()
        cell.CategoryImage.kf.setImage(with: URL(string: productPriceArray?[indexPath.row].images[0].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        cell.categoryPrice.text = calcCurrency(price:productPriceArray?[indexPath.row].variants?[0].price)
       

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
         let productDetailsView = ThirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        productDetailsView.product =  productPriceArray?[indexPath.row]
         self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
extension SearchViewController : UISearchBarDelegate{
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            productPriceArray = brandProducts
        }
        else{
            productPriceArray = productPriceArray!.filter({ Products in
                Products.title.uppercased().hasPrefix(searchText.uppercased()) ||
                Products.title.uppercased().contains(searchText.uppercased())
         
             
            })
        
        }
        self.brandDetailsCollectionView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.endEditing(true)
    }
   
}
extension SearchViewController {
    func data(flag : Int){
        switch flag {
        case 0 : // Coming from Home
            BrandDetailsURL = getURL(endPoint: "products.json")
            viewModel = ViewModelProduct()
            viewModel?.getProducts(url: BrandDetailsURL ?? "")
            viewModel?.bindResultToViewController = {
                self.renderView()
            }
           
        case 1 : // going to brand details
            BrandDetailsURL = getURL(endPoint: "products.json?collection_id=\(brandID ?? 0)") 
            viewModel = ViewModelProduct()
            viewModel?.getProducts(url: BrandDetailsURL ?? "")
            viewModel?.bindResultToViewController = {
                self.renderView()
            }
          
      case 2 : // coming from category
          brandProducts =  productPriceArray ?? []
        
        default:
            break
        }
        
    }
    func renderView(){
        DispatchQueue.main.async {
            self.brandProducts = self.viewModel?.resultProducts.products
      
            self.productPriceArray = self.brandProducts
            self.brandDetailsCollectionView.reloadData()
        }
    }
}
extension SearchViewController : FireActionInCategoryCellProtocol
{
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
    
}

