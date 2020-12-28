//
//  Notifications.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    // Функция, которая запрашивает разрешение на уведомление и планирует уведомление
    func requestAutorization() {
        notificationCenter.requestAuthorization(
            options: [.alert,
                      .sound,
                      .badge,
                      .providesAppNotificationSettings]
        ) { (granted, error) in
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    // функция, которая запрашивает разрешение
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func scheduleNotification(title: String, body: String) {
        
        let content = UNMutableNotificationContent()
        let userActions = "User Actions"
        
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = userActions
        
        content.threadIdentifier = title
        
        content.summaryArgument = title
        content.summaryArgumentCount = 10
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let identifire = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if #available(iOS 14.0, *) {
            completionHandler([.list, .sound, .badge, .banner])
        } else {
            // Fallback on earlier versions
        }
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notification with the Local Notification Identifire")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
            scheduleNotification(title: "Reminder", body: "Body")
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
        completionHandler()
    }
}
