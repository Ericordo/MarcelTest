//
//  FavoritesTableViewCell.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var favoriteLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    private func setUpCell() {
        self.backgroundColor = Colors.favoriteCellColor
    }

    func configure(with favorite: Favorite) {
        favoriteLabel.text = favorite.type?.capitalizingFirstLetter()
        addressLabel.text = favorite.address
        if let type = favorite.type {
            iconImageView.image = UIImage(named: type)
        }
    }
}
