//
//  WishListViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class WishListViewController: UIViewController {
    var favoritesArray = [Products]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favoritesViewModel: FavoritesViewModel?
    
    @IBOutlet weak var wishlistcollection: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        favoritesViewModel = FavoritesViewModel()
        favoritesViewModel?.bindingData = { favourites, error in
            if let favourites = favourites {
                self.favoritesArray = favourites
                DispatchQueue.main.async {
                    self.wishlistcollection.reloadData()
                    
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
                
            }
        }
        favoritesViewModel?.fetchfavorites(appDelegate: appDelegate, userId: UserDefaultsManager.shared.getUserID() ?? 1)
    
        self.wishlistcollection.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesViewModel?.bindingData = { favourites, error in
            if let favourites = favourites {
                self.favoritesArray = favourites
                DispatchQueue.main.async {
                    self.wishlistcollection.reloadData()
                    
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
                
            }
        }
        favoritesViewModel?.fetchfavorites(appDelegate: appDelegate, userId: UserDefaultsManager.shared.getUserID() ?? 1)
    
      
        wishlistcollection.delegate = self
        wishlistcollection.dataSource = self
        let nib = UINib(nibName: "CategoryViewCell", bundle: nil)
        self.wishlistcollection.register(nib, forCellWithReuseIdentifier: "categoryItem")
        
        
        self.wishlistcollection.reloadData()
        
        
    }
    
    }
    




extension WishListViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return favoritesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
        cell.favouriteDelegate = self 
        cell.categoryLabel.text = favoritesArray[indexPath.row].title
        cell.CategoryImage.kf.setImage(with: URL(string: favoritesArray[indexPath.row].images[0].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        cell.categoryPrice.text = favoritesArray[indexPath.row].variants![0].price
        cell.checkFavourite(isFav: true, product: favoritesArray[indexPath.row], isInFavController: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         return   CGSize(width: (collectionView.bounds.size.width/2)-22 , height: (collectionView.bounds.size.height/3)-20 )
            


         }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
       
        let productDetailsView = self.storyboard!.instantiateViewController(withIdentifier: "productDetails") as! ProductDetailsViewController
        productDetailsView.product = favoritesArray[indexPath.row]
        self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
}
extension WishListViewController : FireActionInCategoryCellFavourite
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
        func deleteFavourite(appDelegate: AppDelegate, product: Products) {
            favoritesViewModel?.deleteFavourite(appDelegate: appDelegate, product: product)
            favoritesArray = favoritesArray.filter { $0.id != product.id }
            wishlistcollection.reloadData()
        }
    }
    
    

