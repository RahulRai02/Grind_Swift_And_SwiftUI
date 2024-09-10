//
//  11_PushNotifications.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 31/08/24.
//

import SwiftUI
import CoreLocation


class NotificationManager{
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options){sucess,error in
            if let error = error {
                print("ERROR: \(error)")
            }else{
                print("Success")
            }
            
        }
    }
    
    func scheduleNotifications(){
        // Notification Content
        let content = UNMutableNotificationContent()
        
        content.title = "This is my first push notification from an app"
        content.subtitle = "This is an amazing experience to learn all this"
        content.sound = .default
//       content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        // We can schedule notification based on 3 factors:-
        // 1. Time  2. Calender     3. Location based (Suppose you enter a particular shop, if we mark that coordinates, we could send a notification when the user enters the particular area....)
        
        // Time based notification
        // Uncomment below line for time based triggers
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0 , repeats: false)
        
        // Calender based notification
        // Uncomment for calender based notif
//        var dateComponents = DateComponents()
//        dateComponents.hour = 22
//        dateComponents.minute = 40
//        dateComponents.weekday = 2    // Refers to which day of the week the notif will be triggered
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        // Creates a circular region from the coordinate as a center point to the given radius:- Explained use above
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        // Trigger the notification
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
}


struct _1_PushNotifications: View {
    var body: some View {
        VStack{
            Button("Request Permissions"){
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Permissions"){
                NotificationManager.instance.scheduleNotifications()
            }
            Button("Cancel Permissions"){
                
            }
        }
//        .onAppear{
//            UIApplication.shared.applicationIconBadgeNumber = 0
//        }
    }
}

#Preview {
    _1_PushNotifications()
}
