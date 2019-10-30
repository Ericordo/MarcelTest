//
//  ProposalCollectionViewCell.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class ProposalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!

    @IBOutlet weak var rangeImageView: UIImageView!
    @IBOutlet weak var leafImageView: UIImageView!
    @IBOutlet weak var imgBackgroundView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
        // Initialization code
    }

    
    private func setUpCell() {
        imgBackgroundView.layer.cornerRadius = imgBackgroundView.frame.width/2
        
        imgBackgroundView.backgroundColor = Colors.grey
        
        rangeImageView.image = UIImage(named: "Vehicle Placeholder")
        
    }
}
