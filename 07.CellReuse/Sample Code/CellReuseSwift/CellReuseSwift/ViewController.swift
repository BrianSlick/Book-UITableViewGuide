import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var numberOfCellsCreated = 0
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "Default"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil)
        {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
            numberOfCellsCreated++
            print("Number of cells created: \(numberOfCellsCreated)")
        }
        
        cell!.textLabel?.text = "Hello, World"

        if indexPath.row == 3
        {
            cell?.accessoryType = .Checkmark
        }
        else
        {
            cell?.accessoryType = .None
        }

        return cell!
    }
}

