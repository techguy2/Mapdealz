//
//  LocationManager.swift
//  Mapdealz
//
//  Created by Soeb on 10/20/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class LocationNotifyManager:NSObject, UNUserNotificationCenterDelegate {
    
    var center = UNUserNotificationCenter.current()
    lazy var monitoringManager:ESTMonitoringV2Manager = ESTMonitoringV2Manager(desiredMeanTriggerDistance: 2.0, delegate: self)

    func startMonitoringProximity() {
        monitoringManager.startMonitoring(forIdentifiers: ["ec0afcf83dc503a7bfa885de91d01e36"])
        
        // delegate Notification Center & Get User permission
        center.delegate = self
        center.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
            print("Notification allowed ? = \(granted)")
        }
    }
    
    fileprivate func beaconStateName(_ state: ESTMonitoringState) -> String {
        switch state{
        case .unknown:
            return "Unknown"
        case .insideZone:
            return "Inside Zone"
        case .outsideZone:
            return "Outside Zone"
        }
    }
    
}

extension LocationNotifyManager: ESTMonitoringV2ManagerDelegate {
    func monitoringManagerDidStart(_ manager: ESTMonitoringV2Manager) {
        print("Start")
    }
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager, didEnterDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print(" Enter Proximity of Beacon \(identifier)")
        self.showNotification(title: "Hello World", body: "Looks like you are near a becaon")
    }
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager, didExitDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print("Exit proximity of \(identifier)")
        self.showNotification(title: "Good Bye", body: "You are away from the beacon")
    }
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager, didDetermineInitialState state: ESTMonitoringState, forBeaconWithIdentifier identifier: String) {
        print("didDetermineInitialState '\(self.beaconStateName(state))' for beacon '\(identifier)'")
    }
    
    
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager, didFailWithError error: Error) {
        print("we got \(error)")
    }
    
    func showNotification(title: String , body: String,imageURL : String? = nil ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "Becon Notification", content: content, trigger: nil)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("from notifcation \(response)")
    }
    
}
