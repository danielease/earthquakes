//
//  TestDownloader.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-16.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data {
        //Simulate network delay
        try await Task.sleep(
            nanoseconds: UInt64.random(in: 100_000_000...500_000_000)
        )
        return testQuakesData
    }
}
