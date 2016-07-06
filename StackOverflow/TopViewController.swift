//
//  TopViewController.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/26/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit

class TopViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: String = "Cell"

        let topCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! TopCell

        return topCell
    }
}