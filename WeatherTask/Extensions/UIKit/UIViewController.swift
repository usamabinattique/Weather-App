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
    
    func presentAlert(_ title: String?, _ error: Error?, _ msg: String? = nil) {
        let tlt = title ?? "OK"
        let msg = error?.localizedDescription ?? msg ?? "Default Message"
        
        let message: String!
        if let error = error as? DefaultError {
            message = error.description
        } else {
            message = error?.localizedDescription ?? msg
        }
        
        let alert = UIAlertController(title: tlt, message: message)
        alert.addAction("OK", style: .default)
        present(alert, animated: true)
    }
}
