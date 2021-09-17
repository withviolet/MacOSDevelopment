//
//  ViewController.swift
//  IndexTable
//
//  Created by Chen Xiaohan on 2021/9/16.
//

import UIKit

class ViewController: UITableViewController {
    var dictData: NSDictionary!
    var listGroupName: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        self.dictData = NSDictionary(contentsOfFile: plistPath!)
        let tempList = self.dictData.allKeys as! [String]
        self.listGroupName = tempList.sorted(by: <) as NSArray
    }
    
    //MARK: dataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groupName = self.listGroupName[section] as! String
        let listTeams = self.dictData[groupName] as! NSArray
        return listTeams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell! = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? CustomCell
        let section = (indexPath as NSIndexPath).section
        let row = (indexPath as NSIndexPath).row
        let groupName = self.listGroupName[section] as! String
        let listTeams = self.dictData[groupName] as! NSArray
        cell.textLabel?.text = listTeams[row] as? String
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.listGroupName.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groupName = self.listGroupName[section] as! String
        return groupName
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var listTitles = [String]()
        for item in self.listGroupName {
            let title = (item as AnyObject).substring(to: 1) as String
            listTitles.append(title)
        }
        return listTitles
    }


}

