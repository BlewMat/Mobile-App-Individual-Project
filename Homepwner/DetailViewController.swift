//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Matthew Blewett on 3/25/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, UITextFieldDelegate {
    
   
    @IBOutlet var winnerField: UITextField!
    @IBOutlet var scoreField: UITextField!
    @IBOutlet var mvpField: UITextField!
    @IBOutlet var loserField: UITextField!
    @IBOutlet var locationField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var itemStore: ItemStore!
    var itemsView: ItemsViewController!
    
    
   @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
          view.endEditing(true)
      }
    
    
    var item: Item! {
        didSet{
            //navigationItem.title = item.winner
            navigationItem.title = "Superbowl \(item.sb ?? "")"
        }
    }
    
    
    @IBAction func deleteItem(_ sender: UIBarButtonItem) {
        
        let title = "Delete Superbowl \(item.sb ?? "")?"
        let message = "Are you sure you want to delete this item?"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            
            self.itemsView.itemDataSource.removeItem(self.item)
            _ = self.navigationController?.popViewController(animated: true)
            
        })
        
        ac.addAction(deleteAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.winnerField.text = item.winner
        self.scoreField.text = item.score
        self.mvpField.text = item.mvp
        self.loserField.text = item.loser
        self.locationField.text = item.location
        self.dateLabel.text = item.date
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.winner = winnerField.text ?? ""
        item.score = scoreField.text
        item.mvp = mvpField.text ?? ""
        item.loser = loserField.text ?? ""
        item.location = locationField.text ?? ""
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
