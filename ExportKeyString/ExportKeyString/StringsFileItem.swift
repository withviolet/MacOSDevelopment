//
//  StringsItem.swift
//  Localizations
//
//  Created by darling on 2018/5/30.
//  Copyright © 2018年 darling. All rights reserved.
//

import Cocoa


let StringsFilePattern = "\".*\"\\s*=\\s*\".*\"\\s*;"
let StringsSeparatorPattern = "\"\\s*=\\s*\""

/// 行类型
///
/// - translation: 翻译
/// - blankline  : 空白
/// - comments   : 注释
enum StringsRowType: Int {
    case translation
    case blankline
    case comments
}


/// 基类
class StringsBase: NSObject {
    var rawString: String

    init(with rawString: String) {
        self.rawString = rawString
        super.init()

        self.setup()
    }

    /** 不含空格的字符串 */
    var noSpaceStrings: String {
        return rawString.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }

    /** 子类化, 用来构造对象 */
    func setup() -> Void {
        //nothing
    }

    /** 序列化 */
    func serialization(with fileHandler: FileHandle) -> Void {
        let toWriteString = String(format: "%@\n", rawString)
        guard let data = toWriteString.data(using: .utf8) else { return }

        fileHandler.seekToEndOfFile()
        fileHandler.write(data)
    }
}


/// 翻译对象
class TranslationItem: StringsBase {
    /** 左侧描述 */
    var key           : String?

    /** 右侧翻译 */
    var value         : String?


    /** 被修改 */
    var polluted      : Bool = false

    /** 被排除的，不添加 */
    var excluded      : Bool = false

    /** content display pixels*/
    var displayPixels : Int {
        guard let displayString = value else { return 0 }

        let attribute = [NSAttributedString.Key.font : NSFont.systemFont(ofSize: 15.0)]
        let nsString = NSString(string: displayString)
        let rect = nsString.boundingRect(with: NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                         options: NSString.DrawingOptions.usesLineFragmentOrigin,
                                         attributes: attribute,
                                         context: nil)
        return Int(rect.width)
    }

    override func setup() -> Void {
        super.setup()

        //包含=号的, 不能以=号分割
        var separator = "="
        let result = rawString.match(withPattern: StringsSeparatorPattern)
//        if let match = result, match.count > 0 {
//            separator =
//        }

        let translation = rawString.trimmingCharacters(in: CharacterSet(charactersIn: ";")).components(separatedBy: separator)
        if translation.count == 2 {
            //解决类似这种格式(分号前面有空格): "xxx" = "yyy" ;
            var first = String(translation[0]).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)//"xxx
            var second = String(translation[1]).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)//yyy"

            //print(">>>>>>1 KEY:\(first), VALUE:\(second)")

            let startIndex = first.index(first.startIndex, offsetBy: 1)
            //key = String(first[startIndex..<first.endIndex])
            first = String(first.suffix(from: startIndex))//xxx

            let endIndex = second.index(before: second.endIndex)
            //value = String(second[..<endIndex])
            second = String(second.prefix(upTo: endIndex))//yyy

            self.key = first.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            self.value = second.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

            //print(">>>>>>2 KEY:\(String(describing: self.key)), VALUE:\(String(describing: self.value))")
        }
    }

    /** 添加字符串 */
    func add(with string: String) {
        guard let value = value else { return }

        let tempValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        self.value = tempValue + string

        /*
         guard let value = value else { return }

         let tempValue = value.trimmingCharacters(in: .whitespacesAndNewlines)

         let index = tempValue.index(before: tempValue.endIndex)
         let new = tempValue.prefix(upTo: index)

         let newValue = String(format: "%@%@\"", String(new), string)
         self.value = newValue
         */
    }

    /** 序列化 */
    override func serialization(with fileHandler: FileHandle) -> Void {
        guard let key = key else { return }
        guard let value = value else { return }
        let toWriteString = String(format: "\"%@\" = \"%@\";\n", key, value)
        guard let data = toWriteString.data(using: .utf8) else { return }
        fileHandler.seekToEndOfFile()
        fileHandler.write(data)
    }

    /** 检查每行语法是否正确 */
    func check() -> Bool {

        guard let key = key, let value = value else { return false }

        /**
         符合 "title" = "content";
         */
        if key.hasPrefix("\"") && key.hasSuffix("\"") &&
            value.hasPrefix("\"") && value.hasSuffix("\"") &&
            self.noSpaceStrings.hasSuffix(";")
        {
            return true
        }

        return false
    }

    override var description: String {
        return "\n" +
            "Key          : \(key ?? "")\n" +
            "Value        : \(value ?? "")\n" +
            "DisplayPixels: \(displayPixels)\n" +
            "UTF8 Count   : \(value?.utf8.count ?? -1)"
    }
}


/// 行对象
class StringsRowItem    : StringsBase {
    var rowType         = StringsRowType.translation
    var translation     : TranslationItem?

    override func setup() -> Void {
        super.setup()

        if rawString.isEmpty {
            rowType = .blankline
        }else if self.isTranslationType {
            translation = TranslationItem(with: rawString)
            //print(translation!)
        }else {
            //注释行(可能是部分注释)
            rowType = .comments
        }
    }

    var isTranslationType: Bool {
        if self.noSpaceStrings.hasPrefix("\"") && self.noSpaceStrings.contains("\"=\"") {
            return true
        }

        return false
    }

    /** 添加字符串 */
    func add(with string: String) {

        if self.isTranslationType {
            translation?.add(with: string)
        }
    }
}


/// Localizations.strings 文件对象
class StringsFileItem: NSObject {
    /** 文件路径 */
    var filePath            : String

    /** 语言 */
    var language            : String?

    /** 行对象数组 */
    var rowItems            = [StringsRowItem]()

    /** 翻译对象数组 */
    var translationItems    = [StringsRowItem]()

    /** 是否选中 */
    var selected            = false

    /** 文件名 */
    var fileName: String {
        let url = URL(fileURLWithPath: filePath)
        return url.lastPathComponent
    }

    init(with path: String) {
        self.filePath = path

        super.init()

        parse()
    }

    func rowItem(for key: String) -> StringsRowItem? {
        for item in translationItems {
            guard let translation = item.translation else { continue }
            guard let aKey = translation.key else { continue }

            if key == aKey {
                return item
            }
        }

        return nil
    }

    /** 解析文件 */
    func parse() -> Void {

        if !FileManager.default.fileExists(atPath: filePath) {
            print(">>> File<%@> is not existed!", filePath)
        }

        /*
        //不能保留原来的排版
        //key中的引号转义消失了
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return }
        guard let temp = try? PropertyListSerialization.propertyList(from: data, options: [.mutableContainers], format: nil) else { return }

        guard let dict = temp as? [String:String]  else {
            return
        }

        for row in dict {
            let key = row.key
            let value = row.value
            let rowString = String(format: "\"%@\" = \"%@\";", key, value)
            let item = StringsRowItem(with: rowString)
            if item.rowType == .translation {
                translationItems.append(item)
            }
            rowItems.append(item)
        }
        */

//        guard let strings = try? String(contentsOfFile: filePath) else { return }
//        guard let rows = strings.matches(withPattern: StringsFilePattern) as? [String] else { return }//不能保留原来的排版
//        //let rows = strings.split(separator: "\n", omittingEmptySubsequences: false)//可以保留原来的排版, 准确性不够
//        for row in rows {
//            let rowString = String(row)
//            let item = StringsRowItem(with: rowString)
//            if item.rowType == .translation {
//                translationItems.append(item)
//            }
//            rowItems.append(item)
//        }
    }

    /** 保存 */
    func save(to path: String) -> Void {
        guard let fileHandler = FileHandle(forWritingAtPath: path) else { return }

        for row in rowItems {
            if row.isTranslationType {
                row.translation?.serialization(with: fileHandler)
            }else {
                row.serialization(with: fileHandler)
            }
        }
    }
}

extension String {
    func match(withPattern: String)-> Array<String> {
        var array = [String]()

        var express = try! NSRegularExpression(pattern: withPattern, options: .caseInsensitive)

        let tempString = express.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: self.count), withTemplate: "")

        express = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return array
    }
}
