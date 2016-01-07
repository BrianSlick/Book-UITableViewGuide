//
//  ViewController.swift
//  SetupWithSwiftIB
//
//  Created by Brian Slick on 1/7/16.
//  Copyright © 2016 Brian Slick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showButtonPressed(sender: AnyObject)
    {
        let customViewController = CustomViewController()
        presentViewController(customViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

