//
//  ProductsModel.swift
//  garment
//
//  Created by Muhammad Anum on 09/11/2021.
//

import UIKit
import CoreData

public protocol ProductViewDelegate: class {
    func loadProductsData(_ datas: [Product])
}


final class ProductViewModel {
    
    let storageManager: StorageManager = StorageManager()
    public var delegate: ProductViewDelegate?
    
    public func fetchData(key: String, ascending: Bool) {
        
        let data = storageManager.fetchData(key: key, ascending: ascending)
        delegate?.loadProductsData(data)
    }
    
}




