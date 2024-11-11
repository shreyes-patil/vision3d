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
    @StateObject var navVM = NavigationViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                InventoryListView()
                    .environmentObject(navVM)
            }
        }
        WindowGroup(id: "item"){
            InventoryItemView().environmentObject(navVM)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 1, depth: 1, in: .meters)
    }
}
