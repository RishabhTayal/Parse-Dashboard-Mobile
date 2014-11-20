//
//  PDButton.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/20/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDButton: UIButton {

    override func drawRect(rect: CGRect) {
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true        
    }
}
