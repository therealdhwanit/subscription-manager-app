//
//  NotificationManager.swift
//  SubscriptionManager
//
//  Created by Dhwanit Kumawat on 5/14/25.
//

import Foundation
import UserNotifications
import CoreData

/// Centralizes all your UNUserNotificationCenter calls.
class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    /// Schedule one reminder for a subscription.
    func schedule(_ subscription: Subscription) {
        // only if the user actually wants a reminder
        guard subscription.reminder >= 0,
              let payDate = subscription.paymentDate
        else { return }

        let calendar = Calendar.current

        // 1) compute the date to fire: paymentDate minus `reminder` days
        guard let fireDate = calendar.date(
                byAdding: .day,
                value: -Int(subscription.reminder),
                to: payDate
        ) else { return }

        // 2) split out year/month/day
        var comps = calendar.dateComponents([.year, .month, .day], from: fireDate)
        // 3) split out hour/minute from the user’s reminderTime
        let timeComps = calendar.dateComponents([.hour, .minute], from: subscription.reminderTime ?? Date())
        comps.hour   = timeComps.hour
        comps.minute = timeComps.minute

        // 4) build the trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)

        // 5) content
        let content = UNMutableNotificationContent()
        content.title = "Upcoming Subscription: \(subscription.title ?? "")"
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        content.body  = "Your subscription renews on \(df.string(from: payDate))."
        content.sound = .default

        // 6) use the Core Data objectID URI as a stable identifier
        let id = subscription.objectID.uriRepresentation().absoluteString
        let request = UNNotificationRequest(identifier: id,
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ Failed to schedule:", error)
            }
        }
    }

    /// Cancel any pending reminder for this subscription
    func cancel(_ subscription: Subscription) {
        let id = subscription.objectID.uriRepresentation().absoluteString
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [id])
    }
}
