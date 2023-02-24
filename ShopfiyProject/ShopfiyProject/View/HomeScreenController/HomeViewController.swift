//
//  HomeViewController.swift
//  ShopifyProj
//
//  Created by Asmaa_Abdelfattah on 30/11/1401 AP.
//

import UIKit
import Kingfisher
class HomeViewController: UIViewController ,NavigationBarProtocol{
    var timer : Timer?
    var currentIndex : Int = 0
    @IBOutlet weak var favHomeBtn: UIButton!

    @IBOutlet weak var pageController: UIPageControl!
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
        pageController.numberOfPages = 10
        startTimer()
      
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func moveToNext(){
        if currentIndex  < 9
        {
            currentIndex += 1
        }
        else{
            currentIndex = 0
        }
        OffersCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0) , at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentIndex
    }
    @objc func TapSearch(){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
       // view.searchArr = brands
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
         return   CGSize(width: (UIScreen.main.bounds.size.width/2)-52 , height: (UIScreen.main.bounds.size.height/4)-50 )
            
    }
        
      return CGSize(width:collectionView.frame.size.width
              , height: collectionView.frame.size.height)

         }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == brandCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand", for: indexPath) as! BrandCollectionViewCell
            cell.layer.cornerRadius = CGFloat(20)
        
            cell.brandTitle.text = brands?[indexPath.row] ?? ""
            cell.brandImage.kf.setImage(with: URL(string: "lgbeRMjbrxR+qmJomZCh/Y5rIvgtLRXK/jOHfSGivcItWPNCYSDL5dLKnoTTcrgPhZHgO2uDhZDVrvpB4bWcQ4ipyn5zo52pI4QPqaP1gVwxx1lzEGiFeh/YL8DSfZ6Uw30o7PPQcVE5Y6IMpz8o3LBiAUaicZvzbL7Pi3gECmXrA7FrBWgHwVD3oVw7BlJhKFwEroUBAbDapD8ohLHrSLHjjhVU7NbcsyvUOccSZzTj" ), placeholder: UIImage(named: "brand.png"))
            return cell
        }
      let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offer", for: indexPath) as! OffersCollectionViewCell
        cell.cornerRadius = CGFloat(20)
  
      cell.offerImage.kf.setImage(with: URL(string:"BiKVkhFqK0KP+UxRB6G626fZj/WpGMMMVboXaQ5zGobh953n3XHiS9PVQDIXeRQhtQvY/wAQnQsqGCW+hOA3WUe++GIq3RYrwaT65zs6q8NrcjFedkN6RkGAEER8Xa/2xzfXrFMn1WyD4f0Ai88zgE269kCuH34cBUBkzpZvHhJbxY6aMg1Myb5oIrs1jyar0srFUO2vtLM6U7lUq8t281+2RIKwmMFR0lw9G7r8V2i5jPdXFH4jd9s1g5IuD615BM9ro95j6L6UImfaqDZfT2Dw4LZZMmxDF36ANXjLkYgbfNsJEevkue9Wvbudtt+Zvsjjto0m0P7kuJhz4l0EUHXsr15l4MXKZyEaDyXOc8C/HKBpcHNdBCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgyP8V/wF96J0P0GFc1AAAAABJRU5ErkJggg"), placeholder: UIImage(named: "brand.png"))
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == brandCollectionView){
            let brandDetailsController = self.storyboard?.instantiateViewController(withIdentifier: "brandDetails") as! BrandDetailsViewController
            brandDetailsController.brandName = brands?[indexPath.row] ?? ""
            
            self.navigationController?.pushViewController(brandDetailsController, animated: true)
        }}
    
}
