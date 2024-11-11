//
//  XCVisionApp.swift
//  XCVision
//
//  Created by Shreyas Patil on 11/4/24.
//

import SwiftUI
import FirebaseFirestore


@main
struct XCVisionApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                InventoryListView()
            }
        }
    }
}
