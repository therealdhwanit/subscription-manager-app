//
//  Subscription+CoreDataClass.swift
//  SubscriptionManager
//
//  Created by Dhwanit Kumawat on 5/13/25.
//

import Foundation
import CoreData

@objc(Subscription)
public class Subscription: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.startDate = Date()
    }
    
}
