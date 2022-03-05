//
//  UIAlertController.swift
//  WeatherTask
//
//  Created by usama on 03/03/2022.
//

import UIKit

public extension UIAlertController {

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - style: <#style description#>
    convenience init(title: String?, message: String?, style: UIAlertController.Style = .alert) {
        self.init(title: title, message: message, preferredStyle: style)
    }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - style: <#style description#>
    ///   - handler: <#handler description#>
    func addAction(_ title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) {
        addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
}
