//
//  ViewController.swift
//  SimpleTable
//
//  Created by Chen Xiaohan on 2021/9/13.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var maintableView: UITableView!
    
    var listTeams: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        self.listTeams = NSArray(contentsOfFile: plistPath!)
    }
    
    //MARK: dataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let row = (indexPath as NSIndexPath).row
        let rowDict = self.listTeams[row] as! NSDictionary
        let imagePath = String(format: "%@.png", rowDict["image"] as! String)
        let textString = rowDict["name"] as! String
        cell.textLabel?.text = textString
        cell.imageView?.image = UIImage(named: imagePath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count
    }

}

