//
//  CategoryViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 01/12/1401 AP.
//

import UIKit
import Floaty
class CategoryViewController: UIViewController {

    @IBOutlet weak var favCategoryBtn: UIButton!
    @IBOutlet weak var categoryCartBtn: UIButton!
    @IBOutlet weak var categorySearch: UIButton!
    @IBOutlet weak var FloatButton: Floaty!
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var categorySegmented: UISegmentedControl!
    var append : String?
    var mainCategory : [String]?
    var flag : Int = 0
    var viewModel : ViewModelProduct?
    var CategoryProductsURL : String?
    var productArray : ResponseProducts?
    var WomenArray : [Products]?
    var KidArray : [Products]?
    var SaleArray : [Products]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainCategory = ["?collection_id=437787230489" , "?collection_id=437787263257" , "?collection_id=437787296025" , "?collection_id=437787328793"]
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.CategoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
        categorySegmented.selectedSegmentIndex = 0
        selectSubCategory()
        categorySearch.addTarget(self, action: #selector(TapSearch), for: .touchUpInside)
        categoryCartBtn.addTarget(self, action: #selector(TapCart), for: .touchUpInside)
        favCategoryBtn.addTarget(self, action: #selector(Tapfavourite), for: .touchUpInside)
        CategoryProductsURL = "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/products.json"

        append  = mainCategory![0]
         modelling(newUrl: append)
        self.CategoryCollectionView.reloadData()
    }
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
         //   self.searchedLeagues = self.productArray
            self.CategoryCollectionView.reloadData()
        }
    }
    
    @IBAction func selectedSegment(_ sender: Any) {
        switch categorySegmented.selectedSegmentIndex {
        case 0:
            append  = mainCategory![0]
            modelling(newUrl: append)
            flag = 0
            self.CategoryCollectionView.reloadData()
             case 1 :
            append  = mainCategory![1]
             modelling(newUrl: append)
            flag = 1
            self.CategoryCollectionView.reloadData()
             case 2:
            append  = mainCategory![2]
             modelling(newUrl: append)
            flag = 2
            self.CategoryCollectionView.reloadData()
             case 3:
            append  = mainCategory![3]
             modelling(newUrl: append)
            flag = 3
            self.CategoryCollectionView.reloadData()
             default:
                 break
     
        }
    
    }
    @objc func TapSearch(){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
      //  view.searchArr = arr
     //   view.SearchBar!.placeholder = "Search For You Favourite Product!"
        self.navigationController?.pushViewController(view, animated: true)
    }
    @objc func Tapfavourite(){
        let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
        let view = ThirdStoryBoard.instantiateViewController(withIdentifier: "favorite") as! WishListViewController

        self.navigationController?.pushViewController(view, animated: true)
    }
    @objc func TapCart(){
        let SecondStoryBoard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        let view = SecondStoryBoard.instantiateViewController(withIdentifier: "secondStoryboard1") as! ShoppingCartViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func selectSubCategory(){
        
        FloatButton.addItem( icon: UIImage(systemName: "tshirt.fill")!) {  FloatyItem in
            self.append  = self.mainCategory![self.flag]+"&product_type=T-SHIRTS"
            self.modelling(newUrl: self.append)
           
            self.CategoryCollectionView.reloadData()
            
      }
        FloatButton.addItem( icon: UIImage(systemName: "handbag.fill")!) { [self] FloatyItem in
            self.append  = self.mainCategory![self.flag]+"&product_type=ACCESSORIES"
            self.modelling(newUrl: self.append)
            self.CategoryCollectionView.reloadData()
        }
        FloatButton.addItem( icon: UIImage(systemName: "shoeprints.fill")!) { [self] FloatyItem in
            self.append  = self.mainCategory![self.flag]+"&product_type=shoes"
            self.modelling(newUrl: self.append)
            self.CategoryCollectionView.reloadData()
        }
        FloatButton.addItem( icon: UIImage(systemName: "cross")!) { FloatyItem in
            self.append  = "?collection_id=437787230489"
            self.modelling(newUrl: self.append)
            self.CategoryCollectionView.reloadData()
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
        cell.categoryLabel.text = productArray?.products[indexPath.row].title
        cell.categoryLabel.adjustsFontSizeToFitWidth = true
        cell.CategoryImage.kf.setImage(with: URL(string: productArray?.products[indexPath.row].images[0].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        cell.categoryPrice.text = productArray?.products[indexPath.row].variants![0].price
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         return   CGSize(width: (collectionView.frame.size.width/2)-22 , height: (collectionView.frame.size.height/3)-20 )
            


         }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //product details
       let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
        let productDetailsView = ThirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
          productDetailsView.product = productArray?.products[indexPath.row]
        self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
