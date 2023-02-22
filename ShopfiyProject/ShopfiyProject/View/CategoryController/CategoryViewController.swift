//
//  CategoryViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 01/12/1401 AP.
//

import UIKit
import Floaty
class CategoryViewController: UIViewController  , NavigationBarProtocol{

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
        view.searchArr = arr
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = arr?[flagMainCatgory] ?? ""
        cell.CategoryImage.image = UIImage(named: arrImg[flagSubCatgory])
        cell.categoryPrice.text = "150 EGP"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         return   CGSize(width: (UIScreen.main.bounds.size.width/2)-52 , height: (UIScreen.main.bounds.size.height/4)-20 )
            


         }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //product details
       let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
        let productDetailsView = ThirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
