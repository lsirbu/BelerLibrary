//
//  MyTableViewController.swift
//  MyFramework
//
//  Created by Liliana on 26/01/16.
//  Copyright (c) 2016 Liliana Sirbu. All rights reserved.
//

import UIKit
import BelerLibrary

class MyTableViewController: UITableViewController, CustomNavigationBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationController?.setupPulltoRefresh(self.tableView, viewController: self)
    }

    
    func downloadData() {
        let link = "http://visipad.belersoft.ro/WebService2.asmx/" + "GetAllPatient"
        let parameters = [
            "sId"  : "0efe65c6-5fb4-49b7-b180-a122a0142416",
            "d1"    : "",
            "practicianID"    : "2"]  // build your dictionary however appropriate
        
        ServiceManager.HTTPGetJSON(link, postDictionary: parameters)
            {
                (data: Dictionary<String, AnyObject>, error: String?) -> Void in
                if (error != nil) {
                    println(error!)
                } else {
                    print(data)
                
                    dispatch_async(dispatch_get_main_queue(), {
                        print("stop refresh")
                        self.navigationController?.stopRefresh()
                    })
                    
                    
                    //self.tableView.reloadData()
                    //self.savePatientsCoreData(sessionId, data:data)
                }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath) as! UITableViewCell
        
        return cell
    }
}
