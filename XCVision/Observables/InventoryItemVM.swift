//
//  InventoryItemVM.swift
//  XCVision
//
//  Created by Shreyas Patil on 11/11/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import RealityKit

class InventoryItemViewModel: ObservableObject {
    
    
    @Published var item: InventoryItem?
    @Published var usdzFileURL: URL?
    @Published var entity : ModelEntity?
    
    
    var onItemDeleted : (() -> Void)? = nil
    
    func listenToItem(_ item: InventoryItem) {
        self.item = item
        Firestore.firestore().collection("items").document(item.id).addSnapshotListener {[weak self] snapshot, error in
            guard let self, let snapshot else {
                print("error fetching snapshot : \(error?.localizedDescription ?? "error")")
                return
            }
            
            if !snapshot.exists {
                self.onItemDeleted?()
                return
            }
            self.item = try? snapshot.data(as: InventoryItem.self)
            if let usdzURL = item.usdzURL {
                Task{
                    await self.fetchfileURL(usdzURL: usdzURL)
                }
            }else {
                self.entity = nil
                self.usdzFileURL = nil
            }
        }
    }
    @MainActor
    func fetchfileURL(usdzURL : URL) async {
        guard let url = usdzURL.usdzFileCacheURL else {
            return
        }
        
        if let usdzFileURL, usdzURL.lastPathComponent == url.lastPathComponent {
            return
        }
        
        do{
            
            if !FileManager.default.fileExists(atPath: url.absoluteString){
                _ = try await Storage.storage().reference(forURL: usdzURL.absoluteString)
                    .writeAsync(toFile: url)
            }
            let entity = try await ModelEntity(contentsOf: url)
            entity.name = item?.usdzURL?.absoluteString ?? ""
            entity.generateCollisionShapes(recursive: true)
            entity.components.set(InputTargetComponent())
            self.usdzFileURL = url
            self.entity = entity
            
        }catch{
            self.usdzFileURL = nil
            self.entity = nil
            
        }
    }
    
}
