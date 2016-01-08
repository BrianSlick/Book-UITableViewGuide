import UIKit

class CustomTableViewController: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("\(view)")
        print("\(tableView)")
        
        let subview = UIView.init(frame: CGRectMake(50, 50, 100, 100))
        subview.backgroundColor = UIColor.redColor()
        view.addSubview(subview)
    }
    
    // MARK: - UITableViewDataSource Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Default")
        
        cell.textLabel?.text = "Hello, World"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        print("Tapped row \(indexPath.row)")
    }
}
