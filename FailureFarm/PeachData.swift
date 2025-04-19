//
//  data.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/20/25.
//

import Foundation
import SwiftData

@Model
class PeachData: Identifiable {
    
    var id: String
    var name: String
    
    init(name: String) {
        id = UUID().uuidString
        self.name = name
    }
}
