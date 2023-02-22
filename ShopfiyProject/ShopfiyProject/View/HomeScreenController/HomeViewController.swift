//
//  HomeViewController.swift
//  ShopifyProj
//
//  Created by Asmaa_Abdelfattah on 30/11/1401 AP.
//

import UIKit
import Kingfisher
class HomeViewController: UIViewController ,NavigationBarProtocol{
    
    @IBOutlet weak var favHomeBtn: UIButton!

    @IBOutlet weak var cartHomeBtn: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var offerCollectionView: UICollectionView!
    @IBOutlet weak var brandCollectionView: UICollectionView!
    @IBOutlet weak var OffersCollectionView: UICollectionView!
    var brands : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var nib = UINib(nibName: "BrandCollectionViewCell", bundle: nil)
        self.brandCollectionView.register(nib, forCellWithReuseIdentifier: "brand")
        nib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
        self.offerCollectionView.register(nib, forCellWithReuseIdentifier: "offer")
        brands = ["adidas" , "LC Wakiki" , "Defatco" , "Whats'pp" , "Pixi"]
        searchButton.addTarget(self, action: #selector(TapSearch), for: .touchUpInside)
        cartHomeBtn.addTarget(self, action: #selector(TapCart), for: .touchUpInside)
        favHomeBtn.addTarget(self, action: #selector(Tapfavourite), for: .touchUpInside)

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func TapSearch(){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        view.searchArr = brands
      //  view.SearchBar.placeholder = "Search For Your favourite Brands!"
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

}
extension HomeViewController :UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == brandCollectionView){
           
            return brands?.count ?? 0
        

        }
        
        return 10
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       if(collectionView == brandCollectionView){
         return   CGSize(width: (UIScreen.main.bounds.size.width/2)-52 , height: (UIScreen.main.bounds.size.height/4)-20 )
            
    }
        
      return CGSize(width:collectionView.frame.size.width
              , height: collectionView.frame.size.height)

         }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == brandCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand", for: indexPath) as! BrandCollectionViewCell
            cell.layer.cornerRadius = CGFloat(20)
            
            cell.brandTitle.text = brands?[indexPath.row] ?? ""
            cell.brandImage.kf.setImage(with: URL(string: "data:image/png;base64,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" ), placeholder: UIImage(named: "brand.png"))
            return cell
        }
      let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offer", for: indexPath) as! OffersCollectionViewCell
     
  
      cell.offerImage.kf.setImage(with: URL(string:"data:image/png;base64,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"), placeholder: UIImage(named: "brand.png"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == brandCollectionView){
            let brandDetailsController = self.storyboard?.instantiateViewController(withIdentifier: "brandDetails") as! BrandDetailsViewController
            brandDetailsController.brandName = brands?[indexPath.row] ?? ""
            
            self.navigationController?.pushViewController(brandDetailsController, animated: true)
        }}
    
}
