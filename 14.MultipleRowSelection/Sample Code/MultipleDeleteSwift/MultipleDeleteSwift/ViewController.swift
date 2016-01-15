import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    var contents = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        contents = [ "Red", "Orange", "Yellow", "Green", "Blue", "Magenta" ]
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        updateDeleteButtonStatus()
    }
    
    func updateDeleteButtonStatus()
    {
        func setButtonTitle(title: String, enabled: Bool)
        {
            deleteButton.setTitle(title, forState: .Normal)
            deleteButton.enabled = enabled
        }
        
        let rootButtonTitle = "Delete"
        
        if tableView.editing != true
        {
            setButtonTitle(rootButtonTitle, enabled: false)
        }
        else
        {
            if let selection = tableView.indexPathsForSelectedRows
            {
                if selection.count == 0
                {
                    setButtonTitle(rootButtonTitle, enabled: false)
                }
                else
                {
                    setButtonTitle(rootButtonTitle + " (\(selection.count))", enabled: true)
                }
            }
            else
            {
                setButtonTitle(rootButtonTitle, enabled: false)
            }
        }
    }
    
    @IBAction func editButtonTapped(sender: UIButton)
    {
        tableView.setEditing(!tableView.editing, animated: true)
        
        sender.setTitle(tableView.editing ? "Done" : "Edit", forState: .Normal)
        
        updateDeleteButtonStatus()
    }
    
    @IBAction func reloadButtonTapped(sender: UIButton)
    {
        tableView.reloadData()
        
        updateDeleteButtonStatus()
    }
    
    @IBAction func deleteButtonTapped(sender: UIButton)
    {
        if var selection = tableView.indexPathsForSelectedRows
        {
            if selection.count > 0
            {
                selection.sortInPlace{ $1.compare($0) == .OrderedAscending }
                
                for indexPath in selection
                {
                    contents.removeAtIndex(indexPath.row)
                }
                
                tableView.deleteRowsAtIndexPaths(selection, withRowAnimation: .Automatic)
                
                updateDeleteButtonStatus()
            }
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
        
        let rowValue = contents[indexPath.row];
        
        cell.textLabel?.text = rowValue
        
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        updateDeleteButtonStatus()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        updateDeleteButtonStatus()
    }
}