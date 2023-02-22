//
//  ViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 01/12/1401 AP.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var splashImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.splashImg.image = UIImage(imageLiteralResourceName: "app")
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
           
           UIView.transition(with: self.splashImg,
                             duration: 2.0,
                             options: .transitionCrossDissolve,
                             animations: {
                               self.splashImg.image = UIImage(imageLiteralResourceName: "app")
           }, completion: nil)
    }
}

