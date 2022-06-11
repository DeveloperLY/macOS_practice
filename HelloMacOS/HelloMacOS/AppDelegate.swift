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
    @IBOutlet weak var modalSessionWindow: NSWindow!
    
    var sessionCode: NSApplication.ModalSession?
    
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

    // MARK: - Event
    @IBAction func showModalWindowButtonDidClick(_ sender: NSButton) {
        NSApplication.shared.runModal(for: self.modalWindow)
    }

    // 模态会话窗口
    @IBAction func showSessionModalWindowButtonDidClick(_ sender: NSButton) {
        sessionCode = NSApplication.shared.beginModalSession(for: self.modalSessionWindow)
    }
    
    // 退出模态窗口状态
    // 对于任意一种模态窗口关闭后还必须而外调用结束模态的方法去结束状态
    @objc func windowClose(_ aNSNotification: NSNotification) {
        if let sessionCode = sessionCode {
            NSApplication.shared.endModalSession(sessionCode)
            self.sessionCode = nil
        }
        
        if let window = aNSNotification.object as? NSWindow {
            if self.modalWindow == window {
                NSApplication.shared.stopModal()
            }
            
            if window == self.window {
                NSApp.terminate(self)
            }
        }
    }

}

