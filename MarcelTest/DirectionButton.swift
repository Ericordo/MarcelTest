//
//  DirectionButton.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class DirectionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
    }
    
    
    
    
    
    func setUpButton() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.setTitle("   Où allez-vous ?", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        
        
    }

}
