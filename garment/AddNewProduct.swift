//
//  AddNewProduct.swift
//  garment
//
//  Created by Muhammad Anum on 09/11/2021.
//

import UIKit

class AddNewProduct: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    let storageManager: StorageManager = StorageManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func saveProduct(_ sender: Any) {
        
        if let name = nameField.text {
            if name.isEmpty {
                presentAlert(withTitle: "Error", message: "Please type Product name")
                
            }else {
                storageManager.insertProduct(name: name)
                storageManager.save { (success) in
                    if success {
                        self.navigationController?.dismiss(animated: true, completion: {
                        })
                    }
                }
            }
        }
    }
    
    
}

extension AddNewProduct: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
