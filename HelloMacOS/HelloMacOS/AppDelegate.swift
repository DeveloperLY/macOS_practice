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
    @IBOutlet weak var modalWindow: NSWindow!
    
    @IBAction func showModalWindowButtonDidClick(_ sender: NSButton) {
        NSApplication.shared.runModal(for: self.modalWindow)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // 做一些应用启动前的初始化处理
        
        // 监听窗口关闭事件
        NotificationCenter.default.addObserver(self, selector: #selector(self.windowClose(_:)), name: NSWindow.willCloseNotification, object: nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        // 做一些应用退出前的全局性数据区和资源的清理和释放
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    // 退出模态窗口状态
    @objc func windowClose(_ window: NSWindow) {
        NSApplication.shared.stopModal()
    }

}

