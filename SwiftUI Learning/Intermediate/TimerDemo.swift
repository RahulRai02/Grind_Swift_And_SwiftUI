//
//  TimerDemo.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 16/11/24.
//

import SwiftUI

struct TimerDemo: View {
    
    // Timer is Publisher
    // OnReceive is Subscriber
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    // Autoconnet is liek the timer will start publishing as soon as we load the view.
    
    // Current time
    /*
    @State var currentDate : Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    
    // Count Down
    /*
    @State var count: Int = 5
    @State var finishedText: String? = nil
    */
    
    
    // Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining(){
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
    */
    
    // Animation Counter
    /*
    @State var count : Int = 0
    */
    
    // Tab View
    @State var count : Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color.blue.opacity(0.5), Color.blue],
                center: .center,
                startRadius: 5,
                endRadius: 500
            )
            .ignoresSafeArea()
            // Countdown
            /*
            Text(finishedText ?? "\(count)")
            */
            // Countdown to date
            /*
            Text(timeRemaining)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
             */
            // Animation Counter
            /*
            HStack(spacing: 15){
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
            }
            .frame(width: 150)
            .foregroundColor(.white)
            */
            
            // Tab View
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        // Subscribing - Listen to Publisher
        .onReceive(timer, perform: { _ in
            // Countdown
            /*
            if count <= 1 {
                finishedText = "Wow!"
            }else{
                count -= 1
            }
            */
            // Countdown to date
            /*
            updateTimeRemaining()
             */
            
            // Animation Counter
            // Make sure the duration is same as the timer time
            /*
            withAnimation(.easeInOut(duration: 1.0)){
                count = count == 3 ? 0 : count + 1
            }
            */
            
            //Tab View
            withAnimation(.default){
                count = count == 5 ? 0 : count + 1
            }
            
        })
    }
}

#Preview {
    TimerDemo()
}
