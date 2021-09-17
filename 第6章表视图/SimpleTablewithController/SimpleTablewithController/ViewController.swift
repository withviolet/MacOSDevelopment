//
//  ViewController.swift
//  SimpleTablewithController
//
//  Created by Chen Xiaohan on 2021/9/13.
//

import UIKit

class ViewController: UITableViewController {
    var listTeams: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        self.listTeams = NSArray(contentsOfFile: plistPath!)
        // Do any additional setup after loading the view.
    }
    
    //MARK: datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell! = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? CustomCell
        let row = (indexPath as NSIndexPath).row
        let rowDict = self.listTeams[row] as! NSDictionary
        cell.myLabel.text = rowDict["name"] as? String
        let imagePath = String(format: "%@.png", rowDict["image"] as! String)
        cell.myImageView.image = UIImage(named: imagePath)
        return cell!
    }
    
}

