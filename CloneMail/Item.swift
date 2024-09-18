//
//  Item.swift
//  CloneMail
//
//  Created by Tsubasa on 2024/09/19.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
