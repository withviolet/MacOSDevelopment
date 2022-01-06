//
//  ExportKeyString.swift
//  ExportKeyString
//
//  Created by Chen Xiaohan on 2022/1/5.
//

import Foundation

let ProjectLocation = "/Users/chenxiaohan/StudySpace/icarefone_for_mac/Src/"

class ExportKeyString: NSObject {
    var keyArray: Array<String>!
    var enCleanArray: Array<String>!
    
    override init() {
        super.init()
        
        self.setup()
    }
    
    func setup() -> Void {
        self.keyArray = [String]()
        self.enCleanArray = [String]()
    }
    
    //传入project所在位置，导出文件中所有使用的key值
    func generateKeyStringArray(projectLocation: String) -> Array<String> {
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(atPath: projectLocation)
        while let element = enumerator?.nextObject() as? String {
            if element.hasSuffix(".m") || element.hasSuffix(".mm"){
                let filePath = projectLocation + element
                let text = try! String(contentsOfFile: filePath, encoding: .utf8)
                let regex = "LocalString\\(@\".*?\"\\)"
                let tempArray = regulayExpression(regularExpress: regex, validateString: text)
                keyArray.append(contentsOf: tempArray)
                let regex1 = "Localized\\(@\".*?\"\\)"
                let tempArray1 = regulayExpression(regularExpress: regex1, validateString: text)
                keyArray.append(contentsOf: tempArray1)
            }
        }
        let resultArray = Array(Set(keyArray))
        self.keyArray = resultArray
        return resultArray
    }
    
    func exportKeyStringToExcel(keyArray: Array<String>) {
        addToExcel(array: keyArray)
    }
    
    func regulayExpression(regularExpress: String, validateString: String) -> [String] {
        do {
            let regex = try NSRegularExpression.init(pattern: regularExpress, options: [])
            let matches = regex.matches(in: validateString, options: [], range: NSRange(location: 0, length: validateString.count))
            var res: [String] = []
            for item in matches {
                var str = (validateString as NSString).substring(with: item.range)
                str = str.deleteSpecialCharacters(expressString: regularExpress)
                res.append(str)
            }
            return res
        } catch {
            return []
        }
    }
    
    //写入excel文件
    func addToExcel(array: Array<String>) {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("keyString.xlsx")
        
        let book = workbook_new(jsonPath)
        let sheet = workbook_add_worksheet(book, "程序中用到的key")
        var index = 0
        for item in array {
            worksheet_write_string(sheet, lxw_row_t(index), 0, item, nil)
            index = index + 1
        }
        workbook_close(book)
    }
}

//删除一行key的前缀后缀
extension String {
    func deleteSpecialCharacters(expressString: String)-> String {
        var pattern: String = ""
        if(expressString .hasPrefix("LocalString")) {
            pattern = "LocalString\\(@\""
        }else {
            pattern = "Localized\\(@\""
        }
        
        var express = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        
        let tempString = express.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: self.count), withTemplate: "")
        
        pattern = "\"\\)"
        express = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return express.stringByReplacingMatches(in: tempString, options: [], range: NSRange(location: 0, length: tempString.count), withTemplate: "")
    }
}
