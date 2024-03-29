//
//  SearchTableViewCell.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet private weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }

    func configure(with delegate: UITextFieldDelegate?) {
        textField.delegate = delegate
    }
    
    private func setUpCell() {
        self.selectionStyle = .none
    }
}
