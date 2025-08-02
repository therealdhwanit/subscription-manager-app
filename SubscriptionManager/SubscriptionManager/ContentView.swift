//
//  ContentView.swift
//  SubscriptionManager
//
//  Created by Dhwanit Kumawat on 5/13/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var subscriptionResults:
        FetchedResults<Subscription>
    @State private var isPresented: Bool = false
    
    var amount: Double {
        subscriptionResults.reduce(0) { result, subscription in
            return result + subscription.amount
        }
    }
    
    private func deleteSubscription(subsription: Subscription){
        NotificationManager.shared.cancel(subsription)
        viewContext.delete(subsription)
        do{
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Subscriptions")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                
                
                SubscriptionListView(subscriptionResults: subscriptionResults,
                    onDeleteSubscription: deleteSubscription)
            }
            .sheet(isPresented: $isPresented, content: {
                AddSubscriptionView()
            })
            HStack {
                Text("Total Amount:")
                    .font(.title2)
                
                Text(amount as NSNumber, formatter: NumberFormatter.currency)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Subscription") {
                        isPresented = true
                    }
                }
            }.padding()
        }
        
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
