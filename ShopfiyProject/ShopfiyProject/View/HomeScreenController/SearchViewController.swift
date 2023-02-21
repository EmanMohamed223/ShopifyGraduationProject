//
//  SearchViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 02/12/1401 AP.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    var searchArr :[String]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.searchCollectionView.register(nib, forCellWithReuseIdentifier: "categoryItem")
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
extension SearchViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItem", for: indexPath) as! CategoryCollectionViewCell
        cell.CategoryImage.image = UIImage(named:"gradProg")
        cell.categoryLabel.text = searchArr?[indexPath.row] ?? ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  
         return   CGSize(width: (UIScreen.main.bounds.size.width/2)-42 , height: (UIScreen.main.bounds.size.height/4)-20 )
            


         }
    
}
