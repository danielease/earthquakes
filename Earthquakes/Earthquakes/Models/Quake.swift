//
//  Quake.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-15.
//

import Foundation

struct Quake  {
    let magnitude: Double
    let place: String
    let time: Date
    let code: String
    let detail: URL
}
extension Quake: Identifiable {
    var id: String { code }
}
