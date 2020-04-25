//
//  w3CSV.swift
//  Homepwner
//
//  Created by Matthew Blewett on 4/25/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//

import Foundation
import CoreData

enum FlickrError: Error {
    case invalidJSONData
}

enum Method: String {
    case interestingPhotos = "superbowl.csv"
}

struct w3CSV {
    
    /*
    //DONT NEED RIGHT NOW
    private static let baseURLString = "https://emlangdo.w3.uvm.edu/data/superbowl.csv"
    
    private static func w3CSVURL(method: Method, parameters: [String:String]?) -> URL {
        return URL(string: "")!
    }
    //DONT NEED ABOVE
    */
    
    
    static func items(csv: [[String]], into context: NSManagedObjectContext) -> ItemsResult {
        
        var finalItems = [Item]()
        
        
        for row in csv {
            
            if let item = item(row: row, into: context) {
                finalItems.append(item)
            }
        }
    
        
        if finalItems.isEmpty {
            return .failure(FlickrError.invalidJSONData)
        }
        return .success(finalItems)
    }
    
    
    
    static func item(row: [String], into context: NSManagedObjectContext) -> Item? {
        
        let winner = row[2]
        let sb = row[1]
        let score = row[3] + "-" + row[5]
        let loser = row[4]
        let mvp = row[6]
        let location = row[7]
        let date = row[0]
        
        
        var item: Item!
        context.performAndWait {
            item = Item(context: context)
            item.winner = winner
            item.sb = sb
            item.score = score
            item.loser = loser
            item.mvp = mvp
            item.location = location
            item.date = date
        }
        return item
    }
    
}

