//
//  StorageManager.swift
//  garment
//
//  Created by Muhammad Anum on 09/11/2021.
//


import CoreData
import UIKit

public class StorageManager {
    
    private let persistentContainer: NSPersistentContainer
    
    public init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    public convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate unavailable")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    

    public func fetchAll(sorted: Bool = true) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        if sorted {
            let name = NSSortDescriptor(key: #keyPath(Product.name), ascending: true)
            request.sortDescriptors = [name]
        }
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [Product]()
    }
    
    
    public func fetchData(key: String, ascending: Bool) -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let managedContext = persistentContainer.viewContext
        let sort = NSSortDescriptor(key: key, ascending: ascending)
        fetchRequest.sortDescriptors = [sort]
        let results = try? managedContext.fetch(fetchRequest)
        return results ?? [Product]()
    }
    
    
    @discardableResult public func insertProduct(name: String) -> Product? {
        
        guard let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: backgroundContext) as? Product else {
            return nil
        }
        
        product.name = name
        product.created = Date()
        return product
    }
    
    
    public func save(completion: @escaping (Bool) -> ()) {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
                completion(true)
            } catch {
                print("Save error \(error)")
                completion(false)

            }
        }
    }
}
