//
//  ContentView.swift
//  sleep_Better
//
//  Created by shalinth adithyan on 26/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var WakeUpTime = Date.now
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        Text(Date.now,format: .dateTime.day().month().year())
        DatePicker("Enter a date" , selection: $WakeUpTime , in: Date.now...)
        
    }
    
}

#Preview {
    ContentView()
}
