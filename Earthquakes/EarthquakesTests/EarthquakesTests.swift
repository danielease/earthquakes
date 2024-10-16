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
    
    func testGeoJSONDecoderGetsCorrectValueForTsunami() throws {
        let decoder = JSONDecoder()
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        let expectedTsunami = quake.tsunami
        let decodedTsunami = 0
        
        //Validate the tsunami
        XCTAssertEqual(expectedTsunami, decodedTsunami)
        
    }
    
    func testGeoJSONDecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        let decoded = try decoder.decode(
            GeoJSON.self,
            from: testQuakesData
        )
        
        XCTAssertEqual(decoded.quakes.count, 6)
        
        //Assert code field of a quake is as expected
        XCTAssertEqual(decoded.quakes[1].code, "72783692")
        
        //Assert decoded time matches one in sample data
        let expectedSeconds = TimeInterval(1636129061070) / 1000
        let decodedSeconds = decoded.quakes[1].time.timeIntervalSince1970
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func testQuakeDetailsDecoder() throws {
        let decoded = try JSONDecoder().decode(
            QuakeLocation.self,
            from: testDetail_hv72783692
        )
        
        //Verify latitude matches expected value
        XCTAssertEqual(decoded.latitude,
                       19.2189998626709,
                       accuracy: 0.00000000001)
        
        //Verify longitude matches expected value
        XCTAssertEqual(decoded.longitude,
                       -155.434173583984,
                       accuracy: 0.00000000001)
    }

}
