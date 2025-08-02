//
//  SubscriptionListView.swift
//  SubscriptionManager
//
//  Created by Dhwanit Kumawat on 5/13/25.
//

import SwiftUI

struct SubscriptionListView: View {
    
    let subscriptionResults: FetchedResults<Subscription>
    let onDeleteSubscription: (Subscription) -> Void
    
    var body: some View {
        List {
            
            if !subscriptionResults.isEmpty {
                
                ForEach(subscriptionResults) { subscription in
                    NavigationLink(value : subscription) {
                        HStack {
                            Text(subscription.title ?? "")
                            Spacer()
                            VStack {
                                Text(subscription.amount as NSNumber, formatter: NumberFormatter.currency)
                            }
                        }
                    }
                }.onDelete { indexSet in
                    indexSet.map { subscriptionResults[$0]}.forEach(onDeleteSubscription)
                }
                
            } else {
                Text("You have not added any subscriptions.")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
        }
        .listStyle(PlainListStyle())
        .navigationDestination(for: Subscription.self) { subscription in
            SubscriptionDetailView(subscription: subscription)
        }
    }
    
}
