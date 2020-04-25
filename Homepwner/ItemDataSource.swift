//
//  ItemDataSource.swift
//  Homepwner
//
//  Created by Matthew Blewett on 4/25/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//

import UIKit
import CoreData

class ItemDataSource: NSObject, UITableViewDataSource {
    
    var items = [Item]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ItemCell
        
        
        let item = items[indexPath.row]
        
        cell.update(with: item)
       
        return cell
    }
    
    
    func createItem(into context: NSManagedObjectContext) {
        
        var randomscore = "10-3"
        
        let score1 = Int.random(in: 3 ... 54)
        let score2 = Int.random(in: 2 ... 54)
        
        if (score1 > score2){
        randomscore = "\(score1)-\(score2)"
        } else {
        randomscore = "\(score2)-\(score1)"
        }
        
        let randomTeam = ["Detroit Lions", "New York Giants", "Chicago Bears"]
        let randomSB = ["LV", "LVI", "LVII"]
        let randomMVP = ["Matthew Stafford", "Saquon Barkley", "Khalil Mack"]
        let randomLocation = ["Raymond James Stadium", "LA Stadium", "State Farm Stadium"]
        let randomDate = ["02/07/2021", "02/06/2022", "02/05/2023"]
        
        let idx = arc4random_uniform(UInt32(randomTeam.count))
        
        var idx2 = arc4random_uniform(UInt32(randomTeam.count))
        while (idx2 == idx){
            idx2 = arc4random_uniform(UInt32(randomTeam.count))
        }
        
        var newItem : Item!
        context.performAndWait {
        newItem = Item(context: context)
        newItem.winner = "\(randomTeam[Int(idx)])"
        newItem.sb = "\(randomSB[Int(idx)])"
        newItem.score = randomscore
        newItem.loser = "\(randomTeam[Int(idx2)])"
        newItem.mvp = "\(randomMVP[Int(idx)])"
        newItem.location = "\(randomLocation[Int(idx)])"
        newItem.date = "\(randomDate[Int(idx)])"
        
        }
        items.append(newItem)
        
    }
    
    
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = items[fromIndex]
        
        items.remove(at: fromIndex)
        
        items.insert(movedItem, at: toIndex)
        
    }
    
}
