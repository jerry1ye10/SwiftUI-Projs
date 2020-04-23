//
//  ContentView.swift
//  app4
//
//  Created by Jerry Ye on 4/23/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let model = BetterRest_1()
    
    

    var body: some View {
        NavigationView{
        Form{
            Section(header: Text("when do you want to wake up?")){
            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
            }
            VStack{
                
            Text("Desired amount of sleep")
                .font(.headline)

            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
            }
            VStack{

                Picker(selection: $coffeeAmount, label: Text("Daily Coffee Intake")){
                    ForEach(0..<20){ num in
                        Text("\(num) cups")
                        
                    }
                }
            }
        }.navigationBarTitle("BetterRest").navigationBarItems(trailing: Button(action: calculateBedTime){
            Text("Calculate")
        }).alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        }
    }
    func calculateBedTime(){
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is…"
            // more code here
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            
        }
        showingAlert = true

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
