//
//  SeeMoreReviewsViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class SeeMoreReviewsViewController: UIViewController {

    @IBOutlet weak var moreReviewsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        moreReviewsTable.dataSource = self
        moreReviewsTable.delegate = self
        moreReviewsTable.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewtablecell")
        // Do any additional setup after loading the view.
    }
    

   
}
extension SeeMoreReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moreReviewsTable.dequeueReusableCell(withIdentifier: "reviewtablecell", for: indexPath) as! ReviewTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4-40
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UIScreen.main.bounds.size.height/4-40
//    }
    
}
