//
//  ViewController.swift
//  TreeNavigation
//
//  Created by Chen Xiaohan on 2021/9/24.
//

import UIKit

class ViewController: UITableViewController {

    var dictData: NSDictionary!
    var listData: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let plistPath = Bundle.main.path(forResource: "members", ofType: "plist")
        self.dictData = NSDictionary(contentsOfFile: plistPath!)
        self.listData = self.dictData.allKeys as NSArray
        self.title = "信息"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = self.listData[row] as? String
        return cell;
    }
}

