//
//  PDMenuTableFooter.swift
//  ParseBoard
//
//  Created by Rishabh Tayal on 11/20/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

protocol PDMenuFooterDelegate {
    func facebookClicked()
    func twitterClicked()
}

class PDMenuTableFooter: UIView {
    
    var delegate: PDMenuFooterDelegate!

    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    @IBAction func facebookClicked(sender: AnyObject) {
      delegate.facebookClicked()
    }
    
    @IBAction func twitterClicked(sender: AnyObject) {
        delegate.twitterClicked()
    }
}
