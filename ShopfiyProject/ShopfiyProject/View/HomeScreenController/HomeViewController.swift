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
    var viewModel : ViewModelProduct?
    var brandViewModel : BrandViewModel?
    var HomeProductsURL : String?
    var brandArray : SmartCollection?
    
    var discountCodeViewModel : DiscountCodeViewModel!
    var discountCodeUrl : String!
    var discountCodes : [DiscountCode]?
    
    override func viewDidLoad() {
        
        UIPasteboard.general.string = ""
        
        var nib = UINib(nibName: "BrandCollectionViewCell", bundle: nil)
        self.brandCollectionView.register(nib, forCellWithReuseIdentifier: "brand")
        nib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
        self.OffersCollectionView.register(nib, forCellWithReuseIdentifier: "offer")
        
        
        
        searchButton.addTarget(self, action: #selector(TapSearch), for: .touchUpInside)
        cartHomeBtn.addTarget(self, action: #selector(TapCart), for: .touchUpInside)
        favHomeBtn.addTarget(self, action: #selector(Tapfavourite), for: .touchUpInside)

        pageController.numberOfPages = 2
        
        
        loadQueueOperations()


    }
    override func viewWillAppear(_ animated: Bool) {
        self.OffersCollectionView.reloadData()
        self.brandCollectionView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension HomeViewController :UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == OffersCollectionView){
            return (discountCodes?.count ?? 0)+1
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
            return   CGSize(width: (collectionView.frame.size.width/2)-5 , height: (collectionView.frame.size.height/3)-10 )
            
        }
        
        return CGSize(width:collectionView.frame.size.width
                      , height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == brandCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brand", for: indexPath) as! BrandCollectionViewCell
            cell.layer.cornerRadius = CGFloat(20)
       
            cell.brandImage.kf.setImage(with: URL(string: brandArray?.smart_collections[indexPath.row].image.src ?? ""), placeholder: UIImage(named: "none.png"))
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offer", for: indexPath) as! OffersCollectionViewCell
        cell.cornerRadius = CGFloat(20)
        if indexPath.row == 0{
            cell.offerImage.image = UIImage(named: "ad1")
        }
        else{
            cell.offerImage.image = UIImage(named: "ad4")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == OffersCollectionView){
            if indexPath.row != 0{
                let alert = UIAlertController(title:"Get the coupon to enjoy the sale!" , message: "You can use the coupon in the payment!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
                
                alert.addAction(UIAlertAction(title: "Okay, thanks", style: .default , handler: { _ in
                    UIPasteboard.general.string = self.discountCodes?[indexPath.row-1].code
                }))
                self.present(alert, animated: true)
            }
        }
        
        
        if(collectionView == brandCollectionView){
            let brandDetailsController = self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
            
            brandDetailsController.brandName = brandArray?.smart_collections[indexPath.row].title
            brandDetailsController.brandID = brandArray?.smart_collections[indexPath.row].id
            brandDetailsController.data(flag: 1)
            self.navigationController?.pushViewController(brandDetailsController, animated: true)
        }
        
    }
    
  
}
extension HomeViewController {
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
    }

    @objc func moveToNext(){
        if currentIndex < 1
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
        let view  =  self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        view.data(flag: 0)
        self.navigationController?.pushViewController(view, animated: true)
    }
    @objc func Tapfavourite(){
        if UserDefaultsManager.shared.getUserID() != 0 {
            let ThirdStoryBoard = UIStoryboard(name: "ThirdStoryBoard", bundle: nil)
            let view = ThirdStoryBoard.instantiateViewController(withIdentifier: "favorite") as! WishListViewController
            self.navigationController?.pushViewController(view, animated: true)
        }
        else {
            let alert = UIAlertController(title: "You Should Log In First", message: "Please Log In To Could add To Your Favourites", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func TapCart(){
        if UserDefaultsManager.shared.getUserID() != 0   {
        let SecondStoryBoard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        let view = SecondStoryBoard.instantiateViewController(withIdentifier: "secondStoryboard1") as! ShoppingCartViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
        else {
            let alert = UIAlertController(title: "You Should Log In First", message: "Please Log In To Could add To Your Cart", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func renderPriceRules(discountCodes : [DiscountCode]?){
        guard let discountCodes = discountCodes else { return}
        self.discountCodes = discountCodes
        DispatchQueue.main.async {
            self.OffersCollectionView.reloadData()
            self.startTimer()
        }
        
    }
    
    func renderBrands(brandArray : SmartCollection?){
        guard let brandArray = brandArray else { return}
        self.brandArray = brandArray
        DispatchQueue.main.async {
            self.brandCollectionView.reloadData()
        }
    }
    
    func loadQueueOperations(){
        let queue = OperationQueue()
        
        let operation1 = BlockOperation{
            self.discountCodeUrl = getURL(endPoint: "price_rules/1377368047897/discount_codes.json")
            self.discountCodeViewModel = DiscountCodeViewModel()
            self.discountCodeViewModel.getPriceRules(url: self.discountCodeUrl)
            self.discountCodeViewModel.bindResultToViewController = {
                self.renderPriceRules(discountCodes: self.discountCodeViewModel.discountCodeResponse.discount_codes)
            }
            
        }
        
        let operation2 = BlockOperation{
            
            self.HomeProductsURL = getURL(endPoint: "smart_collections.json?since_id=482865238")
            self.brandViewModel = BrandViewModel()
            self.brandViewModel?.getBrands(url: self.HomeProductsURL ?? "")
            self.brandViewModel?.bindResultToHomeViewController = {
                self.renderBrands(brandArray: self.brandViewModel?.resultBrands)
                //[self] () in
                //self.brandArray = self.viewModel?.resultBrands
            }
        }
        
        operation2.addDependency(operation1)
        
        let operation3 = BlockOperation{
            OperationQueue.main.addOperation {
                self.OffersCollectionView.reloadData()
                self.brandCollectionView.reloadData()
            }
        }
        operation3.addDependency(operation2)
        queue.addOperations([operation1,operation2,operation3], waitUntilFinished: true)
    }
    
}
