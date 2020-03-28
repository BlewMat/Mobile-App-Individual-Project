//
//  ItemStore.swift
//  Homepwner
//
//  Created by Matthew Blewett on 3/18/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    
    init() {
        
        
        for _ in 0..<5 {
            createItem()
            
            //Without discarableResult func, use
            //let _ = createItem()
            
        }
 
        
    }
    
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem, at: toIndex)
        
        
    }
    
    
}
