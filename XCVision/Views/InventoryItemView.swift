//
//  InventoryItemView.swift
//  XCVision
//
//  Created by Shreyas Patil on 11/11/24.
//

import SwiftUI

struct InventoryItemView: View {
    
    @EnvironmentObject var navVM : NavigationViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = InventoryItemViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    @Previewable @StateObject var navVM = NavigationViewModel()
    navVM.selectedItem = .init(id:"Z88kXIStCRuU9NNuDyFM",  name:"", quantity: 0)
    return InventoryItemView()
        .environmentObject(navVM)
}
