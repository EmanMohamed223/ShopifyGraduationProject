//
//  WishListViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class WishListViewController: UIViewController {

    @IBOutlet weak var wishlistcollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        wishlistcollection.delegate = self
        wishlistcollection.dataSource = self
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.wishlistcollection.register(nib, forCellWithReuseIdentifier: "categoryItem")
    }
    



}
extension WishListViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
     //   cell.categoryLabel.text = arr?[flagMainCatgory] ?? ""
     //   cell.CategoryImage.image = UIImage(named: arrImg[flagSubCatgory]
//)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         return   CGSize(width: (UIScreen.main.bounds.size.width/2)-42 , height: (UIScreen.main.bounds.size.height/4)-20 )
            


         }
}
