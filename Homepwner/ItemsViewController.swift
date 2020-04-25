//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Matthew Blewett on 3/18/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tableviews: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!
    
    var store: ItemStore!
    let itemDataSource = ItemDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviews.dataSource = itemDataSource
        tableviews.delegate = self
               
        updateDataSource()
               
               store.fetchItems {
                   (ItemsResult) -> Void in
                   
                   self.updateDataSource()
               }
               
               tableviews.rowHeight = 65
    
    }
    
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
        
        itemDataSource.createItem(into: store.persistentContainer.viewContext)
       
        tableviews.reloadData()
    }
    
    
    private func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        let item = itemDataSource.items[indexPath.row]
        
        store.fetchSuperbowl(for: item) { (result) -> Void in
            
            guard let itemIndex = self.itemDataSource.items.firstIndex(of: item),
                case let .success(Superbowl) = result else {
                    return
            }
            
            let itemIndexPath = IndexPath(item: itemIndex, section: 0)
                
            if let cell = self.tableviews.cellForRow(at: itemIndexPath) as? ItemCell {
                
                cell.update(with: item)
        }
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if  editingStyle == .delete {
            let item = itemDataSource.items[indexPath.row]
            
            let title = "Delete Superbowl \(item.sb ?? "")?"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                
                self.itemDataSource.removeItem(item)
                
                self.tableviews.deleteRows(at: [indexPath], with: .automatic)
                
            })
            
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        
        itemDataSource.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem"?:
            if let row = tableviews.indexPathForSelectedRow?.row {
                let item = itemDataSource.items[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.itemsView = self
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableviews.reloadData()
    }
    
    
    private func updateDataSource() {
        store.fetchAllItems {
            (ItemsResult) in
            
            switch ItemsResult {
            case let .success(items):
                self.itemDataSource.items = items
            case .failure:
                self.itemDataSource.items.removeAll()
            }
            self.tableviews.reloadSections(IndexSet(integer:0), with: .automatic)
        }
    }
    
    
    @IBAction func reloadData() {
        
        self.itemDataSource.items.removeAll()
        tableviews.reloadData()
        store.persistentContainer.viewContext.reset()
        
        store.fetchItems {
            (ItemsResult) -> Void in
            
            self.updateDataSource()
        }
    }
    
    
    
    
    //EDIT BUTTON DOES NOT WORK
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    /*
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        
        tableviews.setEditing(!tableviews.isEditing, animated: true)
        
        if tableviews.isEditing {
            self.editButton.title = "Done"
            
            print("Editing")
            
            //tableviews.setEditing(false, animated: true)
        } else {
            self.editButton.title = "Edit"
            
            print("Done")
            
            //tableviews.setEditing(true, animated: true)
        }
      
    }
    */
}
