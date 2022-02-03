//
//  ProductsController.swift
//  garment
//
//  Created by Muhammad Anum on 09/11/2021.
//

import UIKit
import CoreData

class ProductsController: UIViewController {
    
    
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private var viewModel: ProductViewModel?
    fileprivate var products = [Product]() {
        didSet {
            productsTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        changeListOrder(self.segmentControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel = ProductViewModel()
        self.viewModel?.delegate = self
        setupCell()
        
    }
    
    
    //MARK: Actions
    func setupCell() {
        productsTableView?.register(ProductCell.nib, forCellReuseIdentifier: ProductCell.identifier)
    }
    
    @IBAction func addNewProduct() {
        performSegue(withIdentifier: "showProducts", sender: self)
    }
    
    @IBAction func changeListOrder(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewModel?.fetchData(key: "name", ascending: true)
        case 1:
            viewModel?.fetchData(key: "created", ascending: false)
        default:
            break;
        }
    }
}

extension ProductsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        return cell
    }
    
}

extension ProductsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ProductsController: ProductViewDelegate {
    func loadProductsData(_ datas: [Product]) {
        self.products = datas
        
    }
}

