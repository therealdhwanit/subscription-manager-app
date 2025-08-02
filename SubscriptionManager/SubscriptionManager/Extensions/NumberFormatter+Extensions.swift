//
//  NumberFormatter+Extensions.swift
//  SubscriptionManager
//
//  Created by Dhwanit Kumawat on 5/13/25.
//

import Foundation


extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
