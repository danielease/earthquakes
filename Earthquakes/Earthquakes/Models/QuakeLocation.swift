//
//  QuakeLocation.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-15.
//

import Foundation

struct QuakeLocation: Decodable {
    var latitude: Double
    var longitude: Double
    private var properties: RootProperties
    
    struct RootProperties: Decodable {
        var products: Products
        
    }
    
    struct Products: Decodable {
        var origin: [Origin]
    }
    
    struct Origin: Decodable {
        var properties: OriginProperties
    }
    
    struct OriginProperties {
        var latitude: Double
        var longitude: Double
    }
    
    
}

extension QuakeLocation.OriginProperties: Decodable {
    private enum OriginPropertiesCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
