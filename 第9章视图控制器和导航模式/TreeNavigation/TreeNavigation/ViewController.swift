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
        self.title = "投票主页面"
    }

    //MARK: 场景过渡预处理
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "ShowSelectedGroup") {
//            let indexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
//            let selectedIndex = indexPath.row
//
//            let membersViewController = segue.destination as! MembersTableViewController
//            let selectName = self.listData[selectedIndex] as! String
//            membersViewController.listData = self.dictData[selectName] as? NSArray
//            membersViewController.title = selectName
//        }
//    }
    
    //MARK: delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = self.listData[row] as? String
        return cell;
    }
    
    //方法2:点击跳转
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memberController: MembersTableViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MembersTableViewController")
        let selectedIndex = indexPath.row
        let selectedName = self.listData[selectedIndex] as! String
        memberController.listData = self.dictData[selectedName] as? NSArray
        self.navigationController?.pushViewController(memberController, animated: true)
    }
}

