//
//  InventoryListView.swift
//  Vision3D
//
//  Created by Shreyas Patil on 11/8/24.
//

import SwiftUI

struct InventoryListView: View {
    
    @StateObject var vm = InventoryListViewModel()
    
    var body: some View {
        List{
            ForEach(vm.items){
                item in
                InventoryListItemView(item: item)
                    .listRowSeparator(.hidden)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        <#code#>
                    }
            }
            
        }
        .navigationTitle("AR Inventory")
        .onAppear{
            vm.listenToItems()
        }
    }
}

struct InventoryListItemView: View{
    let item : InventoryItem
    var body : some View{
        HStack(alignment: .top, spacing: 16){
            
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.gray.opacity(0.3))
                
                
                if let thumbnailURL = item.thumbnailURL{
                    AsyncImage(url: thumbnailURL){
                        phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            ProgressView()
                        }
                    }
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3),lineWidth: 1))
            .frame(width:150, height: 150)
            
            VStack(alignment: .leading){
                Text(item.name)
                    .font(.headline)
                Text("Quantity:\(item.quantity)")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    NavigationStack{
        InventoryListView()
    }
    
}
