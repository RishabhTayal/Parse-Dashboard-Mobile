//
//  PDAppSelectionViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDAppSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var datasource: [AppInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var buttons: [AnyObject] = []
        
        buttons.append(self.editButtonItem())
        
        var addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addApp")
        buttons.append(addButton)
        
        self.navigationItem.rightBarButtonItems = buttons
        
           datasource = AppInfo.MR_findAll() as [AppInfo]
        // Do any additional setup after loading the view.
    }
    
    func addApp () {
        var sb: UIStoryboard = self.storyboard!
        var vc: PDLoginViewController = sb.instantiateViewControllerWithIdentifier("PDLoginViewController") as PDLoginViewController
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        var app: AppInfo = datasource[indexPath.row] as AppInfo
        cell.textLabel.text = app.appname
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var app: AppInfo = datasource[indexPath.row] as AppInfo
        PDUtitility.setCurrentAppWithAppID(app.appid)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
