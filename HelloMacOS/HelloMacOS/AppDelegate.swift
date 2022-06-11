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
    var myWindow: NSWindow!
    
    func creatWindow() {
        // 创建窗口：使用NSWindow 类创建窗口对象，除了frame参数，还需要指定 styleMask 来确定窗口的样式风格
        let style: NSWindow.StyleMask = [.titled, .closable, .resizable]
        myWindow = NSWindow(contentRect: CGRect(x: 0, y: 0, width: 400, height: 280), styleMask: style, backing: .buffered, defer: false)
        // 显示窗口
        myWindow.makeKeyAndOrderFront(myWindow)
        // 居中
        myWindow.center()
    }
    
    func setWindowTitleImage() {
        self.window.representedURL = URL(string: "WindowTitle")
        self.window.title = "Hello MacOS"
        self.window.standardWindowButton(.documentIconButton)?.image = NSImage(named: "小组件")
    }
    
    func addButtonToTitleBar() {
        let titleView = self.window.standardWindowButton(.closeButton)?.superview
        let registerButton = NSButton(frame: CGRect(x: (self.window.contentView?.frame.size.width)! - 100, y: 0, width: 80, height: 24))
        registerButton.title = "Register"
        registerButton.bezelStyle = .roundRect
        titleView?.addSubview(registerButton)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // 做一些应用启动前的初始化处理
        
        // 监听窗口关闭事件
        NotificationCenter.default.addObserver(self, selector: #selector(self.windowClose(_:)), name: NSWindow.willCloseNotification, object: nil)
        
        // 设置窗口图标
        setWindowTitleImage()
        
        // 设置窗口背景色
        self.window.backgroundColor = NSColor.orange
        
        // 标题栏添加视图
        addButtonToTitleBar()
        
        // 视图启动居中
        self.window.isRestorable = false
        self.window.center()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        // 做一些应用退出前的全局性数据区和资源的清理和释放
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    // 关闭最后一个或者唯一窗口时终止应用
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    // 应用关闭后点击 Dock 菜单再次打开应用
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        self.window.makeKeyAndOrderFront(self)
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
    
    
    @IBAction func createWindowDidClick(_ sender: NSButton) {
        creatWindow()
    }
    
    
    @IBAction func addButtonDidClick(_ sender: NSButton) {
        let textField = NSTextField(frame: CGRect(x: 10, y: 10, width: 300, height: 24))
        textField.stringValue = "Hello MacOS"
        self.window.contentView?.addSubview(textField)
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

