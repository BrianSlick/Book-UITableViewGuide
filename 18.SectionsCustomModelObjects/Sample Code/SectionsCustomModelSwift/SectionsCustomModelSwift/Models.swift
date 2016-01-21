import UIKit

class FoodItem
{
    var name = ""
    var color: UIColor?
    
    init(name: String, color: UIColor?)
    {
        self.name = name
        self.color = color
    }
}

class SectionItem
{
    var sectionName: String?
    var sectionFooter: String?
    var sectionContents = [FoodItem]()
}