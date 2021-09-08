//
//  ViewController.swift
//  DataPickerSample
//
//  Created by Chen Xiaohan on 2021/9/8.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClick(_ sender: Any) {
        let theDate: Date = self.datePicker.date
        let desc = theDate.description(with: Locale.current)
        print("the date picked is: ",desc)
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        print(dateFormatter.string(from: theDate))
        self.label.text = dateFormatter.string(from: theDate)
    }
    
}

