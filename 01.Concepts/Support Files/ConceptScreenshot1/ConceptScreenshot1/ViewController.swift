//
//  ViewController.swift
//  ConceptScreenshot1
//
//  Created by Brian Slick on 12/23/15.
//  Copyright © 2015 Brian Slick. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let headerLabel = UILabel.init()
        headerLabel.text = "Table Header View"
        headerLabel.sizeToFit()
        headerLabel.textAlignment = .Center
        headerLabel.backgroundColor = UIColor.cyanColor()
        tableView.tableHeaderView = headerLabel
        
        let footerLabel = UILabel.init()
        footerLabel.text = "Table Footer View"
        footerLabel.sizeToFit()
        footerLabel.textAlignment = .Center
        footerLabel.backgroundColor = UIColor.magentaColor()
        tableView.tableFooterView = footerLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "blah")
        cell.textLabel!.text = "Row"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Section Footer"
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section Header"
    }
}

