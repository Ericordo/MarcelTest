//
//  FavoritesTableViewCell.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   private func setUpCell() {
        self.backgroundColor = Colors.favoriteCellColor
        
    }
    
}
