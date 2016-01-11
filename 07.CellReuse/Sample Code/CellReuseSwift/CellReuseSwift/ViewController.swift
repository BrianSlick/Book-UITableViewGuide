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
        
        var optionalCell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (optionalCell == nil)
        {
            optionalCell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
            numberOfCellsCreated++
            print("Number of cells created: \(numberOfCellsCreated)")
        }
        
        // At this point, we are certain we have a cell. So let's map to a new variable so that we don't have to deal with the optional past this point.
        let cell = optionalCell!
        
        cell.textLabel?.text = "Hello, World"

        if indexPath.row == 3
        {
            cell.accessoryType = .Checkmark
        }
        else
        {
            cell.accessoryType = .None
        }

        return cell
    }
}

