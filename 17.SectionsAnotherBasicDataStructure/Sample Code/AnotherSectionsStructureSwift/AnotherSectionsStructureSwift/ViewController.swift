import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    var contents = [String: [String]]()
    var headers = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fruitKey = "Fruit"
        let vegetableKey = "Vegetable"
        let sweetKey = "Sweet"
        
        let fruits = [ "Apple", "Banana", "Grape", "Melon" ]
        let vegetables = [ "Carrot", "Celery", "Asparagus" ]
        let sweets = [ "Chocolate", "Pie" ]
        
        contents[fruitKey] = fruits
        contents[vegetableKey] = vegetables
        contents[sweetKey] = sweets
        
        headers.append(fruitKey)
        headers.append(vegetableKey)
        headers.append(sweetKey)
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> String
    {
        let key = headers[indexPath.section]
        if let groupArray = contents[key]
        {
            let text = groupArray[indexPath.row]
            
            return text
        }
        
        return ""
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return headers.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return headers[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let key = headers[section]
        if let groupArray = contents[key]
        {
            return groupArray.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Plain")
        
        let text = itemAtIndexPath(indexPath)
        
        cell.textLabel?.text = text
        
        return cell;
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let text = itemAtIndexPath(indexPath)
        
        print(text)
    }
}

