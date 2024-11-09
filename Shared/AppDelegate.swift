//
//  AppDelegate.swift
//  Vision3D
//
//  Created by Shreyas Patil on 11/7/24.
//

import FirebaseStorage
import FirebaseCore
import FirebaseFirestore
import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        setupFirebaseLocalEmulator()
        return true
    }
    
    func setupFirebaseLocalEmulator(){
        var host = "127.0.0.1"
        
#if !targetEnvironment(simulator)
        host = "10.110.151.215"
        #endif
        
        let settings = Firestore.firestore().settings
        settings.host = "\(host):8080"
        settings.cacheSettings = MemoryCacheSettings()
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        
        
        Storage.storage().useEmulator(withHost: host, port: 9199)
    }
}
