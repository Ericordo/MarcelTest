//
//  ProposalCollectionViewCell.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class ProposalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var rangeLabel: UILabel!
    @IBOutlet private weak var rangeImageView: UIImageView!
    @IBOutlet private weak var leafImageView: UIImageView!
    @IBOutlet private weak var imgBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    private func setUpCell() {
        imgBackgroundView.layer.cornerRadius = imgBackgroundView.frame.width/2
        imgBackgroundView.backgroundColor = Colors.grey
        rangeImageView.image = UIImage(named: "Vehicle Placeholder")
    }
}
