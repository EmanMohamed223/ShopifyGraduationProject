//
//  SplashViewController.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 05/12/1401 AP.
//

import UIKit
import SwiftyGif
class SplashViewController: UIViewController {

    @IBOutlet weak var GIF: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        do {
            let gif = try UIImage(gifName: "spShop.gif")
            self.GIF.setGifImage(gif, loopCount: -1) // Will loop forever
        } catch {
            print(error)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 7) {
           
            self.performSegue(withIdentifier: "splash", sender: nil)
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
