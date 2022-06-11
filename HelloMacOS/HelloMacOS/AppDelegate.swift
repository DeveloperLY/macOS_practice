//
//  AppDelegate.swift
//  HelloMacOS
// 
//  Created by LiuY on 2020/6/11.
//  
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // 做一些应用启动前的初始化处理
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        // 做一些应用退出前的全局性数据区和资源的清理和释放
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

