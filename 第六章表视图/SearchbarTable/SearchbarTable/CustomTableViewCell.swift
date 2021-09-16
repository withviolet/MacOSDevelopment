//
//  CustomTableViewCell.swift
//  SearchbarTable
//
//  Created by Chen Xiaohan on 2021/9/14.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var nameString: String!
    var detailString: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showString(nameString: String, detailString: String) -> Void {
        self.textLabel?.text = nameString
        self.detailTextLabel?.text = detailString
    }

}
