import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    var contents = [String: [String]]()
    var headers = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        populateData()
    }
    
    func populateData()
    {
        let sourceData = [ "Chocolate", "Pie", "Carrot", "Celery", "Asparagus", "Apple", "Banana", "Grape", "Melon", "Strawberry", "Rutabaga", "Papaya"]
        headers = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
        
        for key in headers
        {
            contents[key] = [String]()
        }
        
        for item in sourceData
        {
            let firstLetterRange = item.startIndex..<item.startIndex.advancedBy(1)
            let firstLetter = item[firstLetterRange].uppercaseString
            
            if var section = contents[firstLetter]
            {
                section.append(item)
                contents[firstLetter] = section
            }
            else
            {
                contents[firstLetter] = [ item ]
            }
        }
        
        for (key, section) in contents
        {
            contents[key] = section.sort({ $1 > $0 })
        }
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

