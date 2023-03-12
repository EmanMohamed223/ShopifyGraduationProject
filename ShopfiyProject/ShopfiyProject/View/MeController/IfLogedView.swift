//
//  IfLogedView.swift
//  ShopfiyProject
//
//  Created by Eman on 22/02/2023.
//

import UIKit

class IfLogedView: UIView {
    var delegate : Navigationdelegate?
    var orderVM : orderViewModel?
    var orderURL : String?
    static var orderArray : [Order]?
    @IBOutlet weak var welcomMssg: UILabel!
    
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var wishlistCollection: UICollectionView!
    var favoritesArray = [Products]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favoritesViewModel: FavoritesViewModel?
    
   
    
    @IBAction func moreWishList(_ sender: UIButton) {
        delegate?.Tapfavourite()
    }
    
    @IBAction func moreOrders(_ sender: UIButton) {
        delegate?.navigateToMoreOrders()
    }
  
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        wishlistCollection.delegate = self
        wishlistCollection.dataSource = self
        ordersTable.delegate = self
        ordersTable.dataSource = self
        let nib = UINib(nibName: "CategoryViewCell", bundle: nil)
        self.wishlistCollection.register(nib, forCellWithReuseIdentifier: "categoryItem")
    
        
       
        ordersTable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ordercell")
        
        favoritesViewModel = FavoritesViewModel()
        favoritesViewModel!.bindingData = { favourites, error in
            if let favourites = favourites {
                self.favoritesArray = favourites
            }
            
            if let error = error {
                print(error.localizedDescription)
                
            }
        }
        favoritesViewModel!.fetchfavorites(appDelegate: appDelegate, userId: UserDefaultsManager.shared.getUserID() ?? 1)
        self.wishlistCollection.reloadData()
 
        orderURL = getURL(endPoint: "orders.json")
        modelling(newUrl : getURL(endPoint: "customers/\( UserDefaultsManager.shared.getUserID() ?? 0)/orders.json"))
        
    }
    
    }
extension IfLogedView: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
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
  
        return   CGSize(width: (collectionView.bounds.size.width/2)-22 , height: (collectionView.bounds.size.height/1.2)-20 )
            


         }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
       
      //  delegate?.TapproductDetails()
    }
}
extension IfLogedView : FireActionInCategoryCellFavourite
{
    func showAlertdelet(title:String, message:String, complition:@escaping ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "OK", style: .destructive) { _ in
            complition()
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        delegate?.present(alert: alert)
    }
        func deleteFavourite(appDelegate: AppDelegate, product: Products) {
            favoritesViewModel?.deleteFavourite(appDelegate: appDelegate, product: product)
            favoritesArray = favoritesArray.filter { $0.id != product.id }
            wishlistCollection.reloadData()
        }
    }
    
    
extension IfLogedView : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if IfLogedView.orderArray?.count ?? 0 > 2{
            return 2
        }
        return IfLogedView.orderArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return CGFloat(1)
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView : UIView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderTableViewCell
        cell.layer.cornerRadius = cell.frame.height/3
        cell.pricelabel.text = IfLogedView.orderArray?[indexPath.row].current_total_price
        cell.dateOfOrderlabel.text =  IfLogedView.orderArray?[indexPath.row].created_at
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func modelling(newUrl : String?){
        orderVM  = orderViewModel()
        orderVM?.getOrders(url: newUrl ?? "" )
      
        orderVM?.bindResultToOrderViewController  = { () in
            
            self.renderView()
        }
    }
    func renderView(){
        DispatchQueue.main.async {
            IfLogedView.orderArray  = self.orderVM?.resultOrders.orders ?? []

            self.ordersTable.reloadData()
        }
    }
}
