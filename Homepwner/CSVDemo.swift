//
//  CSVDemo.swift
//  Homepwner
//
//  Created by Matthew Blewett on 4/9/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//

import UIKit

class CSVDemo: NSObject {
     
     func readStringFromURL(stringURL:String)-> String!{
         if let url = NSURL(string: stringURL) {
             do {
                 return try String(contentsOf: url as URL)
             } catch {
                 print("Cannot load contents")
                 return nil
             }
         } else {
             print("String was not a URL")
             return nil
         }
     }
     
    
    func cleanRows(stringData:String)->[String]{
         var cleanFile = stringData
         cleanFile = cleanFile.replacingOccurrences(of:"\r", with: "\n")
         cleanFile = cleanFile.replacingOccurrences(of:"\n\n", with: "\n")
         return cleanFile.components(separatedBy: "\n")
    }
     
    
     func cleanFields(oldString:String) -> [String]{
         let delimiter = "\t"
         var newString = oldString.replacingOccurrences(of: "\",\"", with: delimiter)
         newString = newString.replacingOccurrences(of: ",\"", with: delimiter)
         newString = newString.replacingOccurrences(of: "\",", with: delimiter)
         newString = newString.replacingOccurrences(of: "\"", with: "")
         return newString.components(separatedBy: delimiter)
     }
     
     
     func convertCSV(stringData:String) -> [[String]] {
         
         let rows = cleanRows(stringData: stringData)
         
         var info : [[String]] = []
         var index = 0
         
         for row in rows{
             
            if (index == 0 ){
            index += 1
            } else {
             info.append(row.components(separatedBy: ","))
            }
             
         }
         
         return info
     }
}
