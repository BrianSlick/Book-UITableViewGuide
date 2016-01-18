import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 4;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section < 2
        {
            return "Header"
        }
        return nil
    }

    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        if section == 3
        {
            return "Footer"
        }
        return nil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Plain")
        
        cell.textLabel?.text = "Row"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 12
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        if let headerView = view as? UITableViewHeaderFooterView
        {
            if let label = headerView.textLabel
            {
                label.font = UIFont.boldSystemFontOfSize(8.0)
                label.textAlignment = .Center
                label.textColor = UIColor.yellowColor()
            }
            
            headerView.backgroundView?.backgroundColor = UIColor.blueColor()
        }
    }
}

