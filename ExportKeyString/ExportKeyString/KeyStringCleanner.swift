//
//  DeleteUnusedString.swift
//  ExportKeyString
//
//  Created by Chen Xiaohan on 2022/1/6.
//

import Foundation

let EnStringFilePath = "/Users/chenxiaohan/WorkSpace/icarefone_for_mac/Src/ApplicationProject/iCarefone/Resources/Localization/en.lproj/Localizable.strings"

class KeyStringCleanner: NSObject {
    //传入：keyarray，英语enstring->cleanEnString
    var keyStringsUsed: Array<String>!
    
    override init() {
        super.init()
        self.setup()
    }
    
    func setup() -> Void {
        keyStringsUsed = [String]()
    }
    
    func removeUnusedString(keyArray: Array<String>, enFilePath: String) -> Array<String> {
        let enFileItem = StringsFileItem.init(with: enFilePath)
        enFileItem.parse()
        
        //对象转字典
        var enFileDic : Dictionary<String? , String?> = [ : ]
        var checkDic: Dictionary<String?, Bool> = [:]
        for item in enFileItem.translationItems {
            guard let translation = item.translation else {
                continue
            }
            enFileDic[translation.key] = translation.value
            checkDic[translation.key] = false
        }
        print("程序中有\(enFileDic.count)条文案")
        for key in keyArray {
            checkDic[key] = true
        }
        
        for item in enFileItem.translationItems {
            guard let translation = item.translation else {
                continue
            }
            if checkDic[translation.key] == true {
                let tempString = "\"" + translation.key! + "\" = \"" + translation.value! + "\";"
                keyStringsUsed.append(tempString)
            }
        }
        return keyStringsUsed
    }
    
    func exportCleanEnStringsToFile(array: Array<String>) -> Void {
        let fileName = "/Users/chenxiaohan/WorkSpace/myFile.txt"
        
        let joinedImagesArray = array.joined(separator: "\n") /// separated by newline
        do {
            try joinedImagesArray.write(toFile: fileName, atomically: true, encoding: .utf8)
        } catch {
            print(error)
        }
    }
}
