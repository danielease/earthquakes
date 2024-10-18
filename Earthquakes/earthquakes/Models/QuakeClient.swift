//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-16.
//

import Foundation

class QuakeClient {
    
    var quakes: [Quake] {
        get async throws {
            let data = try await downloader.httpData(from: quakeFeedURL)
            let geoJSON = try decoder.decode(GeoJSON.self, from: data)
            return geoJSON.quakes
            
        }
    }
    
    //URL to fetch quake data from
    private let quakeFeedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    //Custom JSON Decoder
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()
    
    //Use an existential to define a downloader
    private let downloader: any HTTPDataDownloader
    
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
}
