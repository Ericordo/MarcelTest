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

    func configure(with proposal: Proposal) {

        rangeLabel.text = proposal.range?.capitalizingFirstLetter()
        priceLabel.text = String(proposal.price ?? 0) + " €"
        leafImageView.image = proposal.range == "eco" ? UIImage(named: "Leaf") : nil
    }
    
    private func setUpCell() {
        imgBackgroundView.layer.cornerRadius = imgBackgroundView.frame.width/2
        imgBackgroundView.backgroundColor = Colors.grey
        rangeImageView.image = UIImage(named: "Vehicle Placeholder")
    }
}
