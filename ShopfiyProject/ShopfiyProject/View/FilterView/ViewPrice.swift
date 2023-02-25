//
//  PriceView.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 06/12/1401 AP.
//

import UIKit
import MaterialComponents.MaterialSlider
class ViewPrice: UIView {
   var slider : MDCSlider?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func createSlider(){
         slider? = MDCSlider(frame: CGRect(x:136, y:14, width: 242, height: 40))
        slider?.minimumValue = 10
        slider?.value = 10
        slider?.maximumValue = 1000
        slider?.isContinuous = true
        slider?.isStatefulAPIEnabled = true
        slider?.addTarget(self,
                         action: #selector(didChangeSliderValue),
                         for: .valueChanged)
      
       addSubview(slider!)
        
      }

    @objc  func didChangeSliderValue(senderSlider:MDCSlider) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let brandDetailsController = storyboard.instantiateViewController(withIdentifier: "brandDetails") as! BrandDetailsViewController
        brandDetailsController.priceFilter = Int(senderSlider.value)
        slider?.accessibilityLabel = String(describing: senderSlider.value)
        print ("************************")
        print(senderSlider.value)
    }
}
