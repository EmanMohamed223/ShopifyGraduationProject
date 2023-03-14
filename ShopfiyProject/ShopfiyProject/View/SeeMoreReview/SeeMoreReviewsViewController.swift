//
//  SeeMoreReviewsViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class SeeMoreReviewsViewController: UIViewController {

    @IBOutlet weak var moreReviewsTable: UITableView!
    var reviwerImg : [String]?
    var reviewrName : [String]?
    var reviewrcomment : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        moreReviewsTable.dataSource = self
        moreReviewsTable.delegate = self
        moreReviewsTable.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewtablecell")
        // Do any additional setup after loading the view.
        reviwerImg = ["11","22","33","44"]
        reviewrName = ["sandy","Lara","Youseeif" , "Adam"]
        reviewrcomment = ["it was nice","Not Bad ","it eas awesome" , "it's amazing"]
    }
    

   
}
extension SeeMoreReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moreReviewsTable.dequeueReusableCell(withIdentifier: "reviewtablecell", for: indexPath) as! ReviewTableViewCell
        cell.reviewLabel.text = reviewrcomment![indexPath.row]
        cell.reviewerImg.image = UIImage(named: reviwerImg![indexPath.row])

        cell.reviwerLabel.text = reviewrName![indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4-100
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UIScreen.main.bounds.size.height/4-40
//    }
    
}
