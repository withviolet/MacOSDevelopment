//
//  ViewController.swift
//  DeleteAddCell
//
//  Created by Chen Xiaohan on 2021/9/16.
//

import UIKit

class ViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var listTeams: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "单元格插入和删除"
        self.textField.isHidden = true
        
        self.listTeams = NSMutableArray(array: ["黑龙江","吉林","辽宁"])
    }
    
    //是否能进入编辑状态
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
        if editing {
            self.textField.isHidden = false
        }else{
            self.textField.isHidden = true
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //编辑图标
        if((indexPath as NSIndexPath).row == self.listTeams.count) {
            return .insert
        }else{
            return .delete
        }
    }
    
    //移动列表项
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let stringToMove = self.listTeams[(sourceIndexPath as NSIndexPath).row] as! String
        self.listTeams.removeObject(at: (sourceIndexPath as NSIndexPath).row)
        self.listTeams.insert(stringToMove, at: (destinationIndexPath as NSIndexPath).row)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //插入删除
        let indexPaths = [indexPath]
        if(editingStyle == .delete) {
            self.listTeams.removeObject(at: (indexPath as NSIndexPath).row)
            self.tableView.deleteRows(at: indexPaths, with: .fade)
        }else if(editingStyle == .insert) {
            self.listTeams.insert(self.textField.text!, at: self.listTeams.count)
            self.tableView.insertRows(at: indexPaths, with: .fade)
        }
        self.tableView.reloadData()
    }
    
    
    //MARK: dataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell! = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? CustomCell
        let isAddCell = (indexPath as NSIndexPath).row == self.listTeams.count
        if(!isAddCell) {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = self.listTeams[(indexPath as NSIndexPath).row] as? String
        }else{
            self.textField.frame = CGRect(x: 40, y: 0, width: 300, height: cell.frame.size.height)
            self.textField.borderStyle = .none
            self.textField.placeholder =  "Add..."
            self.textField.text = ""
            cell.addSubview(self.textField)
        }
        return cell
    }
}

