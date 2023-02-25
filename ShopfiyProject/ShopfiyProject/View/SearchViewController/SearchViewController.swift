//
//  SearchViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 02/12/1401 AP.
//

import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate {
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
   // var searchArr :[String]?
    var productArray : ResponseProducts?
    var searchArr : [Products]?
    var viewModel : ViewModelProduct?
    var CategoryProductsURL : String?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        viewSearch.isHidden = false
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.searchCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
        CategoryProductsURL = "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/products.json"
        viewModel = ViewModelProduct()
        viewModel?.getProducts(url: CategoryProductsURL ?? "")
        viewModel?.bindResultToViewController = { () in
            
            self.renderView()
        }
        self.searchCollectionView.reloadData()
    }
    func renderView(){
        DispatchQueue.main.async {
            self.productArray = self.viewModel?.resultProducts
            self.searchArr = self.productArray?.products
            self.searchCollectionView.reloadData()
        }
        
    }
    @IBAction func BestSellingClicked(_ sender: Any) {
        viewSearch.isHidden = true
    }
    
    @IBAction func priceClicked(_ sender: Any) {
        if(productArray!.products.count > 1){
       
            viewSearch.isHidden = false
    
        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
     
        searchArr = productArray!.products.filter({ Products in
            Double( Products.variants?[0].price ?? "0")! < Double(sender.value)
          
        })
      
                self.searchCollectionView.reloadData()
    }

}
extension SearchViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  print( searchArr!.count )

        return searchArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
       
        cell.categoryLabel.text = searchArr![indexPath.row].title
        cell.CategoryImage.kf.setImage(with: URL(string: searchArr![indexPath.row].images[0].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        cell.categoryPrice.text = searchArr![indexPath.row].variants![0].price
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         return   CGSize(width: (UIScreen.main.bounds.size.width/2)-42 , height: (UIScreen.main.bounds.size.height/4)-20 )
            


         }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchArr = []
        
        if searchText == "" {
            searchArr = self.productArray?.products
        }
        
        for product in self.productArray?.products ?? []
        {
            
            if ( product.title.hasPrefix(searchText.lowercased()) ||      product.title.hasPrefix(searchText.uppercased()) || product.title.contains(searchText.lowercased()) ||        product.title.contains(searchText.uppercased()))
            {
                searchArr?.append(product)
            }
        }
        
        self.searchCollectionView.reloadData()
    }
    
}





