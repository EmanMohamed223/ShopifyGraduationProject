//
//  TabBarViewController.swift
//  ShopifyProj
//
//  Created by Asmaa_Abdelfattah on 01/12/1401 AP.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.changeRadiusTabBar()
    }
    override func viewDidLayoutSubviews() {
        self.changeHeightTabBar()
    }
    func changeRadiusTabBar(){
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 40
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
    }
    func changeHeightTabBar(){
        if UIDevice().userInterfaceIdiom == .phone
        {
            var tabFrame = tabBar.frame
            tabFrame.size.height = 90
        
            tabFrame.origin.y = view.frame.size.height - 80
            tabBar.frame = tabFrame
        }
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
