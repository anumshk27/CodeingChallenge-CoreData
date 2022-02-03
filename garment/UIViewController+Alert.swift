//
//  UIViewController+Alert.swift
//  garment
//
//  Created by Haider Shahzad on 10/11/2021.
//

import UIKit

extension UIViewController {

  func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in

    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
