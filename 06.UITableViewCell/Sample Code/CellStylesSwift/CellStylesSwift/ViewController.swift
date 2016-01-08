import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell
        
        switch(indexPath.row)
        {
        case 1:
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "Value1")
            cell.accessoryType = .DisclosureIndicator
        case 2:
            cell = UITableViewCell(style: .Value2, reuseIdentifier: "Value2")
            cell.accessoryType = .DetailDisclosureButton
        case 3:
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Subtitle")
            cell.accessoryType = .Checkmark
        case 4:
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Subtitle2")
            cell.textLabel?.text = "Hello"
            cell.accessoryType = .DetailButton
            return cell
        default:
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Default")
            cell.accessoryType = .None
        }
        
        cell.textLabel?.text = "Hello"
        cell.detailTextLabel?.text = "World"
        cell.accessoryView = UISwitch()
        cell.imageView?.image = UIImage(named: "image")

        return cell
    }
}

