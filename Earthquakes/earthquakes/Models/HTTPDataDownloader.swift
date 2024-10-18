//
//  HTTPDataDownloader.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-16.
//

import Foundation

let validHTTPStatus = 200...299

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}

//Use extension to implement protocol method for URLSession
extension URLSession : HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(
            from: url,
            delegate: nil) as? (Data, HTTPURLResponse),
              validHTTPStatus.contains(response.statusCode)
        else {
            throw QuakeError.networkError
        }
        
        return data
              
    }
}
