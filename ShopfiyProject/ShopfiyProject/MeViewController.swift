//
//  MeViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 21/02/2023.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var welcomeOrAskingLabel: UILabel!
    @IBOutlet weak var ordersTable: UITableView!
    
    @IBOutlet weak var wishlistcollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       wishlistcollection.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryItem")
        
        ordersTable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ordercell")
    }
    
    @IBAction func moreOrderBtn(_ sender: UIButton) {
        var seemoreOrders = self.storyboard?.instantiateViewController(withIdentifier: "seemoreorder") as! MoreOrdersViewController
         
         self.present(seemoreOrders, animated: true)
        
    }
    @IBAction func MoreWishListBtn(_ sender:UIButton) {
        var seemoreWishList = self.storyboard?.instantiateViewController(withIdentifier: "seemore") as! WishListViewController
         
         self.present(seemoreWishList, animated: true)
    }
    
   

}
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4-40
    }
    
}
extension MeViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
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
