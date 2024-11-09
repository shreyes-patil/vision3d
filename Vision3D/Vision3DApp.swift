//
//  Vision3DApp.swift
//  Vision3D
//
//  Created by Shreyas Patil on 11/4/24.
//

import SwiftUI

@main
struct Vision3DApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                InventoryListView()
            }
        }
    }
}
