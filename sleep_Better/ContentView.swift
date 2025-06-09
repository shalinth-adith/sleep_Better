//
//  ContentView.swift
//  sleep_Better
//
//  Created by shalinth adithyan on 26/05/25.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 6.0
    @State private var WakeUpTime = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        NavigationStack {
            Form{
                Section(){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time" , selection: $WakeUpTime , displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section{
                    
                    Text("Desired amount of sleep ")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours ",value: $sleepAmount ,in:4...12 ,step: 0.25)
                }
                Section{
                    
                    Text("Daily coffee intake")
                        .font(.headline)
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cup(s)",value: $coffeeAmount ,in: 0...20 ,step: 1)
                }
            }
            .navigationTitle(Text("Sleep Better"))
            .toolbar {
                Button("Calculate" ,action: calculateBedtime)
                
                
            }
            .alert(alertTitle,isPresented: $showingAlert ){
                Button("ok"){}
            }message: {
                Text(alertMessage)
            }
        }
        
    }
        func calculateBedtime(){
            do{
                let config  = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                
                let components = Calendar.current.dateComponents([.hour,.minute], from: WakeUpTime)
                let hour = (components.hour ?? 0 ) * 60 * 60
                let minute  = (components.minute ?? 0) * 60
                
                let prediction = try model.prediction(wake: Double(hour + minute),estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                let sleepTime = WakeUpTime - prediction.actualSleep
                
                alertTitle = "Your ideal bedtime is "
                alertMessage = sleepTime.formatted(date:.omitted,time : .shortened)
            }catch {
                alertTitle = "Error"
                alertMessage = "Sorry , there is a problem"
            }
            showingAlert  = true
        }
    }
    


#Preview {
    ContentView()
}
