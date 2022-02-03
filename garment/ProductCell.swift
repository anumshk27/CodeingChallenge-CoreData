//
//  ProductCell.swift
//  garment
//
//  Created by Muhammad Anum on 09/11/2021.
//

import UIKit



class ProductCell: UITableViewCell {
    
    // Set the identifier for the custom cell
    static let identifier = "productCell"

    // Returning the xib file after instantiating it
    static var nib: UINib {
           return UINib(nibName: String(describing: self), bundle: nil)
    }
   
}
