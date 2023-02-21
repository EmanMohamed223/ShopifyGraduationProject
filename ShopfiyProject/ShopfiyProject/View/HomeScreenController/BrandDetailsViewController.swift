//
//  BrandDetailsViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 02/12/1401 AP.
//

import UIKit

class BrandDetailsViewController: UIViewController {

    @IBOutlet weak var brandDetailsCollectionView: UICollectionView!
    var brandName : String?
    var arrImg : [String]?
    var flagCatgory : Int = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        arrImg = [ "ma" , "wo" , "kid"]
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.brandDetailsCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
    }
    
    @IBAction func selectKid(_ sender: Any) {
        flagCatgory = 2
        self.brandDetailsCollectionView.reloadData()
    }
    @IBAction func selectWomen(_ sender: Any) {
        flagCatgory = 1
        self.brandDetailsCollectionView.reloadData()
    }
    
    @IBAction func selectMen(_ sender: Any) {
        flagCatgory = 0
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
        
        return   CGSize(width: (UIScreen.main.bounds.size.width/2)-42 , height: (UIScreen.main.bounds.size.height/4)-20 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = brandName ?? ""
        cell.CategoryImage.image = UIImage(named: arrImg?[flagCatgory]  ?? "brand")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
         let productDetailsView = ThirdStoryBoard.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
         self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}

