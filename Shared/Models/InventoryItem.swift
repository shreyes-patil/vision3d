//
//  InventoryItem.swift
//  Vision3D
//
//  Created by Shreyas Patil on 11/8/24.
//

import FirebaseFirestore
import Foundation


//identifiable- unique identity, equatable- type check
struct InventoryItem: Identifiable, Codable, Equatable{
    
    var id = UUID().uuidString
    @ServerTimestamp var createdAt: Date?
    @ServerTimestamp var updatedAt: Date?
    
    var name : String
    var quantity : Int
    
    var usdzLink: String?
    var usdzURL : URL?{
        guard let usdzLink else {
            return nil
        }
        return URL(string: usdzLink)
    }
    var thumbnailLink : String?
    var thumbnailURL: URL?{
        guard let thumbnailLink else{
            return nil
        }
        return URL(string: thumbnailLink)
    }
    
}
