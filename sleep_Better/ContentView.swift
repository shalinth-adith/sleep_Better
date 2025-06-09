//
//  ContentView.swift
//  sleep_Better
//
//  Created by shalinth adithyan on 26/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 6.0
    @State private var WakeUpTime = Date.now
    @State private var coffeeAmount = 1
    var body: some View {
        NavigationStack {
            VStack{
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Please enter a time" , selection: $WakeUpTime , displayedComponents: .hourAndMinute)
                    .labelsHidden()
                Text("Desired amount of sleep ")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours ",value: $sleepAmount ,in:4...12 ,step: 0.25)
                
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper("\(coffeeAmount) cups",value: $coffeeAmount ,in: 0...20 ,step: 1)
            }
            .navigationTitle(Text("Sleep Better"))
            .toolbar {
                Button("Calculate" ,action: calculateBedtime)
                
            }
        }
        
    }
        func calculateBedtime(){
            
        }
    }
    


#Preview {
    ContentView()
}
