//
//  Navigationdelegate.swift
//  ShopfiyProject
//
//  Created by Eman on 23/02/2023.
//

import Foundation
import UIKit
protocol Navigationdelegate
{
    func navigateToSignup()
    func navigateToSignIn()
    func Tapfavourite()
    func navigateToMoreOrders()
    func TapproductDetails()
    func present(alert: UIAlertController)
}
