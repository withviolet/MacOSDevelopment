//
//  ViewController.swift
//  SearchbarTable
//
//  Created by Chen Xiaohan on 2021/9/14.
//

import UIKit

class ViewController: UITableViewController,UISearchBarDelegate,UISearchResultsUpdating {
    var searchController: UISearchController!
    var listTeams: NSArray!
    //查找后的列表
    var listFilterTeams: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        self.listTeams = NSArray(contentsOfFile: plistPath!)
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        self.searchController.searchBar.scopeButtonTitles = ["中文","英文"]
        self.searchController.searchBar.delegate = self
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.sizeToFit()
    }

    func filterContentForSearchText(_ searchText:String, scope: Int) -> Void {
        if(searchText.count == 0) {
            self.listFilterTeams = NSMutableArray(array: self.listTeams)
            return
        }
        var tempArray: NSArray!
        if(scope == 0) {
            //在中文中查找
            let scopePredicate = NSPredicate(format: "SELF.nameString CONTAINS %@", searchText)
            tempArray = self.listTeams.filtered(using: scopePredicate) as NSArray
            self.listFilterTeams = NSMutableArray(array: tempArray)
        }else if(scope == 1) {
            let scopePredicate = NSPredicate(format: "SELF.detailString CONTAINS %@", searchText)
            tempArray = self.listTeams.filtered(using: scopePredicate) as NSArray
            self.listFilterTeams = NSMutableArray(array: tempArray)
        }else{
            self.listFilterTeams = NSMutableArray(array: self.listTeams)
        }
    }
    
    //MARK: UISearchResultsUpdating delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        self.filterContentForSearchText(searchString!, scope: searchController.searchBar.selectedScopeButtonIndex)
        self.tableView.reloadData()
    }
    
    //MARK: searchBar delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResults(for: self.searchController)
    }
    
    //MARK: tableView dataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! CustomTableViewCell
        let row = (indexPath as NSIndexPath).row
        let rowDict = self.listTeams[row] as! NSDictionary
        let nameAsString = rowDict["name"] as? String
        cell.showString(nameString: nameAsString!, detailString: nameAsString!)
//        cell.nameString = nameAsString
//        cell.detailString = nameAsString
        let imagePath = rowDict["image"] as? String
        cell.imageView?.image = UIImage(named: imagePath!)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

