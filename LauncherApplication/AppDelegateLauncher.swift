//
//  AppDelegate.swift
//  LauncherApplication
//
//  Created by Dhruv Rawat on 2021-07-31.
//

import Cocoa

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@NSApplicationMain
class AppDelegateLauncher: NSObject {

    @objc func terminate() {
        NSApp.terminate(nil)
    }
}

extension AppDelegateLauncher: NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let mainAppIdentifier = "com.macbryte.MacBryte"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty

        if !isRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killLauncher, object: mainAppIdentifier)

            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("MacBryte") //main app name
            
            let applicationPathString = path as String
            
            print("AAAAAAA", applicationPathString)
            
            guard let newPath = URL(string: applicationPathString) else { return }
            
            print(newPath)
            
            NSWorkspace.shared.openApplication(at: newPath, configuration: NSWorkspace.OpenConfiguration(), completionHandler: nil)
        }
        else {
            self.terminate()
        }
    }
}
