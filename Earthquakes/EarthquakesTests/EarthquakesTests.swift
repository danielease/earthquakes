//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Daniel on 2024-10-15.
//

import XCTest
@testable import Earthquakes

final class EarthquakesTests: XCTestCase {

    func testGeoJSONDecoderDecodesQuake() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        XCTAssertEqual(quake.code, "73649170")
     
        let expectedSeconds = TimeInterval(1636129710550) / 1000 //From test data
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        //Validate the time of the quake
        XCTAssertEqual(expectedSeconds,
                       decodedSeconds,
                       accuracy: 0.00001)
        
        
    }

}
