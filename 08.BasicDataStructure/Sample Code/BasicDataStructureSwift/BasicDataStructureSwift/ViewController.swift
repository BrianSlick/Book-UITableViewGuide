import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "PlainCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil)
        {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
        }
        
        if indexPath.row == 0
        {
            cell?.textLabel?.text = "Red"
        }
        else if indexPath.row == 1
        {
            cell?.textLabel?.text = "Orange"
        }
        else if indexPath.row == 2
        {
            cell?.textLabel?.text = "Yellow"
        }
        else if indexPath.row == 3
        {
            cell?.textLabel?.text = "Green"
        }
        else if indexPath.row == 4
        {
            cell?.textLabel?.text = "Blue"
        }
        else if indexPath.row == 5
        {
            cell?.textLabel?.text = "Magenta"
        }
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0
        {
            print("Red")
        }
        else if indexPath.row == 1
        {
            print("Orange")
        }
        else if indexPath.row == 2
        {
            print("Yellow")
        }
        else if indexPath.row == 3
        {
            print("Green")
        }
        else if indexPath.row == 4
        {
            print("Blue")
        }
        else if indexPath.row == 5
        {
            print("Magenta")
        }
    }
}

