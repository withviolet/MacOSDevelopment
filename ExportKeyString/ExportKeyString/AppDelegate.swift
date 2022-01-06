//
//  AppDelegate.swift
//  ExportKeyString
//
//  Created by Chen Xiaohan on 2022/1/5.
//

import Cocoa

@main

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let exporter: ExportKeyString = ExportKeyString.init()
        let keyArray = exporter.generateKeyStringArray(projectLocation: ProjectLocation)
        print("此项目中的key值有\(keyArray.count)条")
        let cleanner: KeyStringCleanner = KeyStringCleanner.init()
        let cleanEnStrings = cleanner.removeUnusedString(keyArray: keyArray, enFilePath: EnStringFilePath)
        print("此项目中使用到的文案有\(cleanEnStrings.count)条")
        cleanner.exportCleanEnStringsToFile(array: cleanEnStrings)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
