//
//  HTTPDataDownloader.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-16.
//

import Foundation

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}
