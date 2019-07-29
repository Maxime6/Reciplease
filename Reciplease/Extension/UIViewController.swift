//
//  UIViewController.swift
//  Reciplease
//
//  Created by Maxime on 11/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /// Display alert with appropriate message
    func displayAlert(title: String, message: String, preferredStyle: UIAlertController.Style) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
