//
//  NotificationHandler.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-07-10.
//

import Foundation
import Cocoa
import UserNotifications

/*
 * Handles notification sending
 */
class NotificationHandler {
    static let shared = NotificationHandler();
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    public func getNotificationAuthorization() {
        // Asks for authorization
        userNotificationCenter.requestAuthorization(options: [.alert, .sound]) { authorized, error in
            if authorized {
                print("Authorized")
            } else if !authorized {
                print("Not Authorized")
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    public func displayNotification(for title: String, with body: String) -> Void {
        userNotificationCenter.getNotificationSettings { settings in
            if .authorized == settings.authorizationStatus {
                self.userNotificationCenter.removeAllPendingNotificationRequests() // Make sure no notification requests remain
                
                let id = "InternetStatusNotification"
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = UNNotificationSound.default
                
                let request = UNNotificationRequest(identifier: id,  content: content, trigger: trigger)
                self.userNotificationCenter.add(request) { (error) in // Queues notification and sends
                    if nil != error {
                        print(error?.localizedDescription as Any)
                    }
                }
            }
        }
    }
}

