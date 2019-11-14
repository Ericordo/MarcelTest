//
//  UserLocationTableViewCell.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class UserLocationTableViewCell: UITableViewCell {

    @IBOutlet private weak var infoImage: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }

    func configureForDeparture() {
        infoImage.image = UIImage(named: "Marker")
        infoImage.image = infoImage.image?.withRenderingMode(.alwaysTemplate)
        infoImage.tintColor = Colors.turquoise
    }

    func configureForDestination(with address: String?) {
        infoImage.image = UIImage(named: "Marker")
        infoLabel.textColor = .black
        infoLabel.text = address
    }

    private func setUpCell() {
        self.selectionStyle = .none
        self.infoLabel.textColor = Colors.turquoise
    }
}
