//
//  InventoryListView.swift
//  XCVision
//
//  Created by Shreyas Patil on 11/10/24.
//

import SwiftUI
import RealityKit


struct InventoryListView: View {
    
    @StateObject var vm = InventoryListViewModel()
    private let gridItems : [GridItem] = [.init(.adaptive(minimum: 240), spacing: 16)]
    
    
    var body: some View {
        
        ScrollView{
            LazyVGrid(columns: gridItems) {
                ForEach(vm.items){
                    item in
                    InventoryListItemView(item: item)
                        .onDrag{
                            guard let usdzURL = item.usdzURL else{return NSItemProvider()}
                            return NSItemProvider(object: USDZItemProvider(usdzURL: usdzURL))
                        }
                    
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 30)
        }
        .navigationTitle("AR Inventory")
        .onAppear{vm.listenToItems()}
        
        
    }
}

struct InventoryListItemView: View{
    let item : InventoryItem
    
    @EnvironmentObject var navVM: NavigationViewModel
    @Environment(\.openWindow) var openWindow
    
    var body: some View{
        Button{
            navVM.selectedItem = item
            openWindow(id: "item")
        } label: {
            VStack{
                ZStack{
                    if let usdzURL = item.usdzURL{
                        Model3D(url: usdzURL){
                            phase in
                            switch phase{
                            case .success(let model):
                                model.resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure(let error):
                                Text("failed to download model: \(error.localizedDescription)")
                            default : ProgressView()
                            }
                        }
                    } else{
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(Color.gray.opacity(0.3))
                        Text("Not available")
                    }
                }
                .frame(width: 160, height: 160)
                .padding(.bottom, 32)
                
                Text(item.name)
                Text("Quantity : \(item.quantity)")
            } .frame(width: 240, height: 240)
                .padding(32)
        }
        .buttonStyle(.borderless)
        .buttonBorderShape(.roundedRectangle(radius: 20))
    }
}

#Preview {
    @Previewable @StateObject var navVM = NavigationViewModel()

    return NavigationStack{
        
        InventoryListView()
            .environmentObject(navVM)
    }
    
}
