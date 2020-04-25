//
//  ItemStore.swift
//  Homepwner
//
//  Created by Matthew Blewett on 3/18/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//

import UIKit
import CoreData


enum ItemsResult {
    case success([Item])
    case failure(Error)
}

enum SuperbowlResult {
    case success(Item)
    case failure(Error)
}

enum ItemError : Error {
    case imageCreationError
}


class ItemStore {
    
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Homepwner")
        container.loadPersistentStores{ (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    
    
    func fetchItems(completion: @escaping (ItemsResult) -> Void) {
        
        let csvDemo = CSVDemo()
        let url = "https://emlangdo.w3.uvm.edu/data/superbowl.csv"
        let text = csvDemo.readStringFromURL(stringURL: url)
        
        let csvFile = csvDemo.convertCSV(stringData: text!)
        
        let result = self.processItemsRequest(csv: csvFile)
        OperationQueue.main.addOperation {
            completion(result)
        }
        
        
    }
    
    
    private func processItemsRequest(csv: [[String]]) -> ItemsResult {
        return w3CSV.items(csv: csv, into: persistentContainer.viewContext)
    }
    
    
    func fetchSuperbowl(for item: Item, completion: @escaping (SuperbowlResult) -> Void){
        
        var result = self.processSuperbowlRequest(item: item)
        
        if case .success = result {
            do {
                try self.persistentContainer.viewContext.save()
            } catch let error {
                result = .failure(error)
            }
        }
        
        OperationQueue.main.addOperation {
            completion(result)
        }
    }
    
    
    private func processSuperbowlRequest(item: Item) -> SuperbowlResult {
        
        let item: Item = item
        /*
        guard
            let item: Item = item else {
            return .failure(ItemError.imageCreationError)
        }
        */
        return .success(item)
        
    }
    
    
    func fetchAllItems(completion: @escaping (ItemsResult) -> Void) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Item.winner), ascending: true)
        fetchRequest.sortDescriptors = [sortByDate]
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform{
            do {
                let allItems = try viewContext.fetch(fetchRequest)
                completion(.success(allItems))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
}
