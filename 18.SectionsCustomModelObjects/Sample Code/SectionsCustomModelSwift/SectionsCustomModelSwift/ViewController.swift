//
//  ViewController.swift
//  SectionsCustomModelSwift
//
//  Created by Brian Slick on 1/21/16.
//  Copyright © 2016 Brian Slick. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    var contents = [SectionItem]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        populateData()
    }

    func populateData()
    {
        let fruitSection = SectionItem()
        fruitSection.sectionName = "Fruits"

        fruitSection.sectionContents.append(FoodItem.init(name: "Apple", color: UIColor.redColor()))
        fruitSection.sectionContents.append(FoodItem.init(name: "Banana", color: UIColor.yellowColor()))
        fruitSection.sectionContents.append(FoodItem.init(name: "Grape", color: UIColor.purpleColor()))

        let veggieSection = SectionItem()
        veggieSection.sectionName = "Vegetables"
        
        veggieSection.sectionContents.append(FoodItem.init(name: "Carrot", color: UIColor.orangeColor()))
        veggieSection.sectionContents.append(FoodItem.init(name: "Celery", color: UIColor.greenColor()))
        
        let sweetSection = SectionItem()
        sweetSection.sectionName = "Sweets"
        sweetSection.sectionFooter = "I love dessert!"
        
        sweetSection.sectionContents.append(FoodItem.init(name: "Chocolate", color: nil))
        
        contents = [ fruitSection, veggieSection, sweetSection ]
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> FoodItem
    {
        let sectionItem = contents[indexPath.section]
        
        return sectionItem.sectionContents[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return contents.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let sectionItem = contents[section]
        
        return sectionItem.sectionContents.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let sectionItem = contents[section]
        
        return sectionItem.sectionName
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        let sectionItem = contents[section]
        
        return sectionItem.sectionFooter
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "Default"
        
        var optionalCell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (optionalCell == nil)
        {
            optionalCell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
        }
        
        let cell = optionalCell!
        
        let foodItem = itemAtIndexPath(indexPath)
        
        cell.textLabel?.text = foodItem.name
        
        if let color = foodItem.color
        {
            cell.textLabel?.textColor = color
        }
        else
        {
            cell.textLabel?.textColor = UIColor.blackColor()
        }

        return cell
    }
}

