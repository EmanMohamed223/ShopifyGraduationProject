//
//  BrandDetailsViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 02/12/1401 AP.
//

import UIKit

class BrandDetailsViewController: UIViewController {

   
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var brandDetailsCollectionView: UICollectionView!
    var brandName : String?
    var arrImg : [String]?
    var flagCatgory : Int = 0
    var price : [String]?
    var priceFilter : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        price = ["100 EGP" , "150 EGP" ]
        arrImg = [ "ma" , "wo" , "kid"]
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.brandDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
        subView.isHidden = true
    }
 
    @IBAction func selectBestSelling(_ sender: Any) {
        flagCatgory = 1
        self.brandDetailsCollectionView.reloadData()
        subView.isHidden = false
    }
    
    @IBAction func selectPrice(_ sender: Any) {
        subView.isHidden = false
        flagCatgory = 0
        priceFilter = 1
        self.brandDetailsCollectionView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BrandDetailsViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return   CGSize(width: (UIScreen.main.bounds.size.width/2)-52 , height: (UIScreen.main.bounds.size.height/4)-50 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = brandName ?? ""
        cell.CategoryImage.image = UIImage(named: arrImg?[flagCatgory]  ?? "brand")
        cell.categoryPrice.text = price?[priceFilter] ?? "0"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
         let productDetailsView = ThirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
         self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}

