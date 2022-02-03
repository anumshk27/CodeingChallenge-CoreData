//
//  garmentTests.swift
//  garmentTests
//
//  Created by Haider Shahzad on 09/11/2021.
//

import XCTest
import CoreData

@testable import garment

class garmentTests: XCTestCase {

    var storageManager: StorageManager?
    
    var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "garment", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in

            precondition(description.type == NSInMemoryStoreType)

            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
            }
        }
        return container
    }()

    override func setUp() {
        super.setUp()
        storageManager = StorageManager(container: mockPersistantContainer)
    }

    func testCheckEmpty() {
        if let storageManager = storageManager {
            let rows = storageManager.fetchAll()
            XCTAssertEqual(rows.count, 0)
        } else {
            XCTFail()
        }
    }
    
    func testInsert() {

        guard let storageManager = storageManager else {
            XCTFail()
            return
        }

        let rowsBefore = storageManager.fetchAll()
        XCTAssertEqual(rowsBefore.count, 0)

        for i in 1...10 {
            XCTAssertNotNil(storageManager.insertProduct(name: "Product \(i)"))
        }

        storageManager.save { (success) in
            let rowsAfter = storageManager.fetchAll()
            XCTAssertEqual(rowsAfter.count, 10)
        }

     
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
