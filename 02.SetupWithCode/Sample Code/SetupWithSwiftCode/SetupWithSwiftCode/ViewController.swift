import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let table = UITableView(frame: CGRectZero, style: .Plain)
        table.dataSource = self
        table.delegate = self
        tableView = table
        view.addSubview(table)
        
        // Auto layout stuff. Just copy-paste if you don't understand it. Questions will not be answered.
        
        var views = [String: AnyObject]()
        views["table"] = table

        table.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Default")
        
        cell.textLabel?.text = "Hello, World"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        print("Tapped row \(indexPath.row)")
    }
}

