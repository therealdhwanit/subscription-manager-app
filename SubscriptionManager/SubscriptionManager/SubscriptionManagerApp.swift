//
//  SubscriptionManagerApp.swift
//  SubscriptionManager
//
//  Created by Dhwanit Kumawat on 5/13/25.
//

import SwiftUI
import UserNotifications

@main
struct SubscriptionManagerApp: App {
    
    init() {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
            ) { granted, error in
                if let error = error {
                    print("Notification auth error:", error)
                }
                // you might want to handle `granted == false`…
            }
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
