//
//  String+Extension.swift
//  Vision3D
//
//  Created by Shreyas Patil on 11/8/24.
//

import Foundation


extension String : Error, LocalizedError{
    
    public var errorDescription: String? {
        self
    }
}
