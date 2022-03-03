//
//  UIViewController.swift
//  WeatherTask
//
//  Created by usama on 03/03/2022.
//

import UIKit
import SVProgressHUD


extension UIViewController {
    func showLoader() {
        view.isUserInteractionEnabled = false
        SVProgressHUD.show()
    }

    func dismissLoader() {
        DispatchQueue.main.async { [self] in
            view.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
        }
    }
}
