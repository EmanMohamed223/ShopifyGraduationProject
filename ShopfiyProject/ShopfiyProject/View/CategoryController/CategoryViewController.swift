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
    var arr : [String]?
    var arrImg : [String] = []
    var flagMainCatgory : Int = 0
    var flagSubCatgory : Int = 0
    var viewModel : ViewModelProduct?
    var CategoryProductsURL : String?
    var productArray : ResponseProducts?
    var MenArray : [Products]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.CategoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
        arr = ["Men", "WOMEN" , "Kid" , "SALE"]
        arrImg = ["brand.png" , "shirt" , "bag" , "shoes"]
        selectSubCategory()
        categorySearch.addTarget(self, action: #selector(TapSearch), for: .touchUpInside)
        categoryCartBtn.addTarget(self, action: #selector(TapCart), for: .touchUpInside)
        favCategoryBtn.addTarget(self, action: #selector(Tapfavourite), for: .touchUpInside)
        CategoryProductsURL = "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/products.json"
        viewModel = ViewModelProduct()
        viewModel?.getProducts(url: CategoryProductsURL ?? "")
        viewModel?.bindResultToViewController = { () in
            
            self.renderView()
        }
        self.CategoryCollectionView.reloadData()
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
      
        flagMainCatgory = 0
            self.CategoryCollectionView.reloadData()
             case 1 :
           
           flagMainCatgory = 1
            self.CategoryCollectionView.reloadData()
             case 2:
            flagMainCatgory = 2
            self.CategoryCollectionView.reloadData()
             case 3:
            flagMainCatgory = 3
            self.CategoryCollectionView.reloadData()
             default:
                 break
     
        }
    
    }
    @objc func TapSearch(){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
     //   view.searchArr = arr
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
        FloatButton.addItem( icon: UIImage(systemName: "tshirt.fill")!) { FloatyItem in
            self.flagSubCatgory = 1
            self.CategoryCollectionView.reloadData()
      }
        FloatButton.addItem( icon: UIImage(systemName: "handbag.fill")!) { FloatyItem in
            self.flagSubCatgory = 2
            self.CategoryCollectionView.reloadData()
        }
        FloatButton.addItem( icon: UIImage(systemName: "shoeprints.fill")!) { FloatyItem in
            self.flagSubCatgory = 3
            self.CategoryCollectionView.reloadData()
        }
        FloatButton.addItem( icon: UIImage(systemName: "cross")!) { FloatyItem in
            self.flagSubCatgory = 0
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
        cell.CategoryImage.kf.setImage(with: URL(string: productArray?.products[indexPath.row].images[0].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        cell.categoryPrice.text = productArray?.products[indexPath.row].variants![0].price
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         return   CGSize(width: (UIScreen.main.bounds.size.width/2)-52 , height: (UIScreen.main.bounds.size.height/4)-50 )
            


         }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //product details
       let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
        let productDetailsView = ThirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
