//
//  PDAddClassViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

protocol PDAddClassDelegate {
    func addClassDidDismiss(controller: PDAddClassViewController, className: String)
}

class PDAddClassViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var textField: UITextField!
    
    var delegate: PDAddClassDelegate! = nil

    override func viewDidLoad() {
        super.viewDidLoad();
        
//        PDUtitility.trackWithScreenName("Add Class")
        
        doneButton.enabled = false
        
        var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 5, 20));
        paddingView.backgroundColor = UIColor.clearColor()
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewMode.Always;
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        delegate!.addClassDidDismiss(self, className: textField.text)

        self.dismissViewControllerAnimated(true, completion: nil)        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //Mark: UITextField Delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text.isEmpty {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
        return true
    }
}
