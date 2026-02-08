//
//  pushNotificationSwiftUi.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 07/01/2026.
//

import SwiftUI

import UserNotifications
import CoreLocation
class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAurthorizatio() {
        let options: UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options){(sucess,error) in
            if let error = error {
                print("\(error)")
            }else{
                print ("Sucess")
            }
        }
    }
    
    func sheduleNotifiation() {
        let content = UNMutableNotificationContent()
        content.title = "Warning"
        content.sound = .default
        content.body = "are shure tou want to delete"
        
//        there are three types of triggers
//        time
//        calender
//        location
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
//        
//        var dateComponenmt = DateComponents()
//        dateComponenmt.hour = 21
//        dateComponenmt.minute = 54
//        let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponenmt , repeats: false)
        let cordinates = CLLocationCoordinate2D(
            latitude:40.00,
            longitude:50.00
        )
        
        
      let region = CLCircularRegion(
        center: cordinates,
        radius: 100,
        identifier: UUID().uuidString
      )
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
       
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
    func cancelNotification() {
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct pushNotificationSwiftUi: View {
    var body: some View {
        VStack {
            Button("request button".capitalized) {
                NotificationManager.instance.requestAurthorizatio()
            }.buttonStyle(.borderedProminent)
            Button("get Notification".capitalized) {
                NotificationManager.instance.sheduleNotifiation()
            }.buttonStyle(.borderedProminent)
            
            Button("cancel Notification".capitalized) {
                NotificationManager.instance.cancelNotification()
            }.buttonStyle(.borderedProminent)
            
        }.onAppear {
//            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

#Preview {
    pushNotificationSwiftUi()
}
