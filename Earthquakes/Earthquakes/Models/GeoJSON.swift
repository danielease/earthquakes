//
//  GeoJSON.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-15.
//

import Foundation

/*
The root object of the GeoJSON data has four keys: type, metadata, features, and bbox
 
 The value of the features key is an array of feature objects, each of which represents an earthquake observation.
 
 Each feature object contains four keys: type, properties, geometry, and id. The value associated with the properties key contains the data will be decoded as a Quake instance.
 */


struct GeoJSON {
    
    /*  Which keys of the GeoJSON root object to decode */
    private enum CodingKeys: String, CodingKey {
        case features
    }
    
    /* Which keys of the feature objects to decode */
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    
    
    
    
    private(set) var quakes: [Quake] = []
}
