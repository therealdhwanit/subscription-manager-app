//
//  AddSubscriptionView.swift
//  SubscriptionManager
//
//  Created by Dhwanit Kumawat on 5/13/25.
//

import SwiftUI

struct AddSubscriptionView: View {
    
    @State private var title: String = ""
    @State private var amount: Double? = nil
    @State private var paymentDate = Date()
    @State private var renewalInterval: Int = 1
    @State private var renewalUnit: String = "months"
    @State private var notes: String = ""
    @State private var reminder: Int = 1
    @State private var reminderTime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!

    
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.managedObjectContext) private var viewContext
    

    var isFormValid: Bool {
        
        if title.isEmpty || (amount ?? 0) <= 0 || renewalInterval <= 0{
            return false
        }
        else{
            return true
        }
    }
    
    
    private func save() {
        
        let subscription = Subscription(context: viewContext)
        subscription.title = title
        subscription.amount = (amount ?? 0)
        subscription.renewalUnit = renewalUnit
        subscription.renewalInterval = Int16(renewalInterval)
        subscription.paymentDate = paymentDate
        
        //save the context
        do{
            try viewContext.save()
            // schedule a local notification
            NotificationManager.shared.schedule(subscription)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("SUBSCRIPTION")) {
                    TextField("Name (Required)", text: $title)
                    TextField("Price (Required)", value: $amount, format: .number.precision(.fractionLength(2)), prompt: Text("Price (Required)"))
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("RENEWAL")) {
                    DatePicker("Start Date", selection: $paymentDate, displayedComponents: .date)
                    HStack {
                        Text("Renews every")
                        Spacer(minLength: 62)
                        TextField("\(renewalInterval)", value: $renewalInterval, format: .number)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 40)
                        Picker("", selection: $renewalUnit) {
                            Text("days").tag("days")
                            Text("weeks").tag("weeks")
                            Text("months").tag("months")
                            Text("years").tag("years")
                        }
                        .pickerStyle(.menu)
                        .tint(.black)
                        
                        
                    }
                }
                
                Section(header: Text("NOTIFICATIONS")) {
                    HStack {
                        
                        Text("Remind me")
                        
                        Picker("", selection: $reminder) {
                            Text("Never").tag(-1)
                            Text("Day of renewal").tag(0)
                            Text("1 day before").tag(1)
                            Text("2 day before").tag(2)
                            Text("3 day before").tag(3)
                            Text("4 day before").tag(4)
                            Text("5 day before").tag(5)
                            Text("6 day before").tag(6)
                            Text("7 day before").tag(7)
                            Text("8 day before").tag(8)
                            Text("9 day before").tag(9)
                            Text("10 day before").tag(10)
                            Text("11 day before").tag(11)
                            Text("12 day before").tag(12)
                            Text("13 day before").tag(13)
                            Text("14 day before").tag(14)
                            Text("15 day before").tag(15)
                            Text("16 day before").tag(16)
                            Text("17 day before").tag(17)
                            Text("18 day before").tag(18)
                            Text("19 day before").tag(19)
                            Text("20 day before").tag(20)
                            Text("21 day before").tag(21)
                            Text("22 day before").tag(22)
                            Text("23 day before").tag(23)
                            Text("24 day before").tag(24)
                            Text("25 day before").tag(25)
                            Text("26 day before").tag(26)
                            Text("27 day before").tag(27)
                            Text("28 day before").tag(28)
                            Text("29 day before").tag(29)
                            Text("30 day before").tag(30)
                        }
                    }
                    
                    DatePicker("Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    
                }
                
                Section(header: Text("NOTES")) {
                    TextField("Enter any notes here", text: $notes)
                }
            }
            .navigationTitle("Add Subscription")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: save)
                        .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    AddSubscriptionView()
}
