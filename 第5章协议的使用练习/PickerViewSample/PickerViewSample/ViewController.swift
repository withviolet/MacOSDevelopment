//
//  ViewController.swift
//  PickerViewSample
//
//  Created by Chen Xiaohan on 2021/9/8.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    var pickerData: NSDictionary!
    var pickerProvincesData: NSArray!
    var pickerCitiesData: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "provinces_cities", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: plistPath!)
        self.pickerData = dict
        
        self.pickerProvincesData = self.pickerData.allKeys as NSArray
        
        let selectedProvince = self.pickerProvincesData[0] as! String
        self.pickerCitiesData = self.pickerData[selectedProvince] as? NSArray
    }

    @IBAction func onClick(_ sender: Any) {
        let row1 = self.pickerView.selectedRow(inComponent: 0)
        let row2 = self.pickerView.selectedRow(inComponent: 1)
        let selected1 = self.pickerProvincesData[row1] as! String
        let selected2 = self.pickerCitiesData[row2] as! String
        let title = String(format: "%@ %@市", selected1,selected2)
        self.label.text = title
    }
    
    //MARK: 实现dataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //拨轮数目
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0) {
            //省份个数
            return self.pickerProvincesData.count
        }else{
            //市个数
            return self.pickerCitiesData.count
        }
    }
    //MARK: 实现UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0) {
            return self.pickerProvincesData[row] as? String
        }else{
            return self.pickerCitiesData[row] as? String
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0) {
            let selectedProvince = self.pickerProvincesData[row] as! String
            self.pickerCitiesData = self.pickerData[selectedProvince] as? NSArray
            self.pickerView.reloadComponent(1)
        }
    }
}

