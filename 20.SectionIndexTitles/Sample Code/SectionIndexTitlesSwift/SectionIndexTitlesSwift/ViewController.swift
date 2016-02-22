import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    var contents = [String: [String]]()
    var headers = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let garageKey = "Garage";
        let masterBathroomKey = "Master Bathroom";
        let diningRoomKey = "Dining Room";
        let guestBathroomKey = "Master Bedroom";
        let kitchenKey = "Kitchen";
        let denKey = "Den";

        let garage = [ "Motor Oil", "Light Bulbs", "Trash Bags", "Flashlight" ];
        let masterBathroom = [ "Soap", "Shampoo", "Toothpaste", "Hair Spray", "First Aid" ];
        let diningRoom = [String]();
        let guestBathroom = [ "Hand Soap", "Tissues", "Toilet Paper" ];
        let kitchen = [ "Milk", "Bread", "Pizza", "Juice", "Cheese", "Coffee" ];
        let den = [ "Pens", "Pencils", "Paper", "Stamps" ];
        
        contents[garageKey] = garage
        contents[masterBathroomKey] = masterBathroom
        contents[diningRoomKey] = diningRoom
        contents[guestBathroomKey] = guestBathroom
        contents[kitchenKey] = kitchen
        contents[denKey] = den
        
        headers.append(garageKey)
        headers.append(masterBathroomKey)
        headers.append(diningRoomKey)
        headers.append(guestBathroomKey)
        headers.append(kitchenKey)
        headers.append(denKey)
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
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]?
    {
        var titles = [String]()
        
        for header in headers
        {
            var title = ""
            let words = header.componentsSeparatedByString(" ")
            for word in words
            {
                let firstLetterRange = word.startIndex..<word.startIndex.advancedBy(1)
                let firstLetter = word[firstLetterRange].uppercaseString
                title = title + firstLetter
            }
            titles.append(title)
        }
        
        return titles
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let text = itemAtIndexPath(indexPath)
        
        print(text)
    }
}

