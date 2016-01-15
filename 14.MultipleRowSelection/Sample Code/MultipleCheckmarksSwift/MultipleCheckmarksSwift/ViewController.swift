import UIKit

// http://stackoverflow.com/a/30724543
extension Array where Element : Equatable {
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var contents = [String]()
    var selectedIndexPaths = [NSIndexPath]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        contents = [ "Red", "Orange", "Yellow", "Green", "Blue", "Magenta" ]
    }
    
    @IBAction func reloadButtonTapped(sender: UIButton)
    {
        tableView.reloadData()
    }
    
    func populateCell(cell: UITableViewCell, indexPath: NSIndexPath)
    {
        let rowValue = contents[indexPath.row];
        
        cell.textLabel?.text = rowValue
        
        if (selectedIndexPaths.contains(indexPath))
        {
            cell.accessoryType = .Checkmark
        }
        else
        {
            cell.accessoryType = .None
        }
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "PlainCell"
        
        var optionalCell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (optionalCell == nil)
        {
            optionalCell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
        }
        
        let cell = optionalCell!
        
        populateCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Method
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (selectedIndexPaths.contains(indexPath))
        {
            selectedIndexPaths.removeObject(indexPath)
        }
        else
        {
            selectedIndexPaths.append(indexPath)
        }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        populateCell(cell, indexPath: indexPath)
    }
}