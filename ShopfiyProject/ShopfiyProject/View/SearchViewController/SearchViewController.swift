//
//  BrandDetailsViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 02/12/1401 AP.
//

import UIKit
import Kingfisher
//import MaterialComponents.MaterialSlider
class SearchViewController: UIViewController {

   
    
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
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = brandName ?? ""
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.brandDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
        subView.isHidden = true
 
        
        self.brandDetailsCollectionView.reloadData()
    }
   
    @IBAction func selectBestSelling(_ sender: Any) {
        if( productPriceArray!.count >= 1 || (brandProducts?.count)! >= 1 ){
            subView.isHidden = true
            productPriceArray = brandProducts
            self.brandDetailsCollectionView.reloadData()
            
        }
       
    }
    
    @IBAction func selectPrice(_ sender: Any) {
        if(productPriceArray!.count >= 1 || (brandProducts?.count)! >= 1){
       
            subView.isHidden = false
    
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
        cell.categoryLabel.text = productPriceArray?[indexPath.row].title
        
        cell.CategoryImage.kf.setImage(with: URL(string: productPriceArray?[indexPath.row].images[0].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        cell.categoryPrice.text = productPriceArray?[indexPath.row].variants?[0].price
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
