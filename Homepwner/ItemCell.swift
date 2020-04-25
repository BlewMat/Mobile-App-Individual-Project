//
//  ItemCell.swift
//  Homepwner
//
//  Created by Matthew Blewett on 3/19/20.
//  Copyright © 2020 Matthew Blewett. All rights reserved.
//

import UIKit


class ItemCell: UITableViewCell {
    
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var sbLabel: UILabel!
    
    
    func update(with item: Item?){
    
    winnerLabel.text = item?.winner
    scoreLabel.text = item?.score
    sbLabel.text = item?.sb
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        winnerLabel.adjustsFontForContentSizeCategory = true
        scoreLabel.adjustsFontForContentSizeCategory = true
        sbLabel.adjustsFontForContentSizeCategory = true
        
        update(with: nil)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
}
