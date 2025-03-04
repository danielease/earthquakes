//
//  QuakeError.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-15.
//
import Foundation

enum QuakeError: Error {
    case missingData
    case networkError
    case unexpectedError(Error)
}

extension QuakeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a quake missing valid code, magnitude, place, or time.",
                comment: "")
        case .networkError:
            return NSLocalizedString("Error fetching quake data over the network.", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
        }
    }
}
