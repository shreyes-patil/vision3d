//
//  NavigationVM.swift
//  XCVision
//
//  Created by Shreyas Patil on 11/11/24.
//

import Foundation
import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var selectedItem: InventoryItem?
    
    
    init(selectedItem: InventoryItem? = nil) {
        self.selectedItem = selectedItem
    }
}
