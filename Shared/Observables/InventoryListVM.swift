//
//  InventoryListVM.swift
//  Vision3D
//
//  Created by Shreyas Patil on 11/8/24.
//

import FirebaseFirestore
import Foundation
import SwiftUI

class InventoryListViewModel: ObservableObject{
    
    @Published var items = [InventoryItem]()
    
    @MainActor
    func listenToItems(){
        Firestore.firestore().collection("items")
            .order(by: "name")
            .limit(to: 100)
            .addSnapshotListener {
                snapshot, error in
                guard let snapshot else{
                    print("Error in fetching snapshot: \(error?.localizedDescription ?? "error")")
                    return
                }
                let docs = snapshot.documents
                let items = docs.compactMap{
                    try? $0.data(as: InventoryItem.self)
                }
                
                withAnimation{
                    self.items = items
                }
            }
    }
}
