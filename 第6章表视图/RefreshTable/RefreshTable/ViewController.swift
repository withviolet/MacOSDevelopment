//
//  ViewController.swift
//  RefreshTable
//
//  Created by Chen Xiaohan on 2021/9/16.
//

import UIKit

class ViewController: UITableViewController {
    var logs: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.logs = NSMutableArray()
        let date = NSDate()
        self.logs.addObjects(from: [date])
        
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action:#selector(refreshTableView), for: UIControl.Event.valueChanged)
        self.refreshControl = rc
    }

    @objc func refreshTableView() -> Void {
        if(self.refreshControl?.isRefreshing == true) {
            self.refreshControl?.attributedTitle = NSAttributedString(string: "加载中")
            let date = NSDate()
            self.logs.addObjects(from: [date])
            self.refreshControl?.endRefreshing()
            self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell! = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? CustomCell
        let row = (indexPath as NSIndexPath).row
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let item = self.logs[row] as! NSDate
        let str = formatter.string(from: item as Date)
        cell.textLabel?.text = str
        return cell
    }
    

}

