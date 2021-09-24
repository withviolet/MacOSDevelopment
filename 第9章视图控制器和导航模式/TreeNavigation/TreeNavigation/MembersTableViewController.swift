//
//  MembersTableViewController.swift
//  TreeNavigation
//
//  Created by Chen Xiaohan on 2021/9/24.
//

import UIKit

class MembersTableViewController: UITableViewController {
    var listData: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let row = indexPath.row
        let dict = self.listData[row] as! NSDictionary
        cell.textLabel?.text = dict["name"] as? String
        return cell
    }
    //MARK: -选择表视图时触发
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowSelectedDetail") {
            let indexPath = self.tableView.indexPathForSelectedRow! as IndexPath
            let selectedIndex = indexPath.row
            let dict = self.listData[selectedIndex] as! NSDictionary
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.url = dict["url"] as? String
            detailViewController.title = dict["name"] as? String
        }
    }
}
