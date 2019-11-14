//
//  ResultTableViewCell.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    private func setUpCell() {
        self.backgroundColor = Colors.resultsTVColor
    }

    func configure(with result: SearchResult) {
        addressLabel.attributedText = result.address
        cityLabel.attributedText = result.city
    }
}
