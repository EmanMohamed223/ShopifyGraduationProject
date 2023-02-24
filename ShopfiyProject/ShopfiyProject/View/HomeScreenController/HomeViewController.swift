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
    @IBOutlet weak var brandCollectionView: UICollectionView!
    @IBOutlet weak var OffersCollectionView: UICollectionView!
    
    
    var brands : [String]?
    var ads : [AdsDetials]?
    var viewModel : ViewModelProduct?
    var HomeProductsURL : String?
    var brandArray : SmartCollection?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ads = getAds()
        var nib = UINib(nibName: "BrandCollectionViewCell", bundle: nil)
        self.brandCollectionView.register(nib, forCellWithReuseIdentifier: "brand")
        nib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
        self.OffersCollectionView.register(nib, forCellWithReuseIdentifier: "offer")
        
        brands = ["adidas" , "LC Wakiki" , "Defatco" , "Whats'pp" , "Pixi"]
        
        searchButton.addTarget(self, action: #selector(TapSearch), for: .touchUpInside)
        cartHomeBtn.addTarget(self, action: #selector(TapCart), for: .touchUpInside)
        favHomeBtn.addTarget(self, action: #selector(Tapfavourite), for: .touchUpInside)
        
        pageController.numberOfPages = ads?.count ?? 0
        startTimer()
        HomeProductsURL = "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/smart_collections.json?since_id=482865238"
        viewModel = ViewModelProduct()
        viewModel?.getBrands(url: HomeProductsURL ?? "")
        viewModel?.bindResultToHomeViewController = { () in
            
            self.renderView()
        }
        self.brandCollectionView.reloadData()
    }
    
    func renderView(){
        DispatchQueue.main.async {
            self.brandArray = self.viewModel?.resultBrands
         //   self.searchedLeagues = self.productArray
            self.brandCollectionView.reloadData()
        }
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
    }

    @objc func moveToNext(){
        if currentIndex < (ads?.count ?? 0)-1
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
        if(collectionView == OffersCollectionView){
            return ads?.count ?? 0
        }
        
        if (collectionView == brandCollectionView){
            return brandArray?.smart_collections.count ?? 0
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
        
            cell.brandTitle.text = brandArray?.smart_collections[indexPath.row].title
            cell.brandImage.kf.setImage(with: URL(string: brandArray?.smart_collections[indexPath.row].image.src ?? ""), placeholder: UIImage(named: "none.png"))
            return cell
        }
        
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offer", for: indexPath) as! OffersCollectionViewCell
        cell.cornerRadius = CGFloat(20)
  
        cell.offerImage.image = UIImage(named: ads?[indexPath.row].image ?? "")
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == OffersCollectionView){
            let alert = UIAlertController(title:"Get the coupon to enjoy the sale!" , message: "You can use the coupon in the payment!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
            
            alert.addAction(UIAlertAction(title: "Okay, thanks", style: .default , handler: { _ in
               //save the coupon with a specific user
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let saveToCoreViewModel = SavetoCoreViewModel()
                let userRelatedObj = UserRelatedStruct(userId: 10,offerCoupon: self.ads?[indexPath.row].code ?? "")
            }))
            self.present(alert, animated: true)
        }
                        
        
        if(collectionView == brandCollectionView){
            let brandDetailsController = self.storyboard?.instantiateViewController(withIdentifier: "brandDetails") as! BrandDetailsViewController
            brandDetailsController.brandName = brands?[indexPath.row] ?? ""
            
            self.navigationController?.pushViewController(brandDetailsController, animated: true)
        }}
    
}
