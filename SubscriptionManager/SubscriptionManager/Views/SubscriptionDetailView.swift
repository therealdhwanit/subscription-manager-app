//
//  SubscriptionDetailView.swift
//  SubscriptionManager
//
//  Created by Dhwanit Kumawat on 5/13/25.
//

import SwiftUI

struct SubscriptionDetailView: View {
    
    let subscription: Subscription
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text(subscription.title ?? "")
                        .font(.largeTitle)
                    HStack {
                        Text("Price")
                        Text(subscription.amount as NSNumber, formatter: NumberFormatter.currency)
                    }.fontWeight(.bold)
                }
            }
            Spacer()
        }
    }
}


//#Preview {
//    SubscriptionDetailView()
//}
