//
//  QuakeError.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-15.
//
import Foundation

enum QuakeError: Error {
    case missingData
}

extension QuakeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a quake missing valid code, magnitude, place, or time.",
                comment: "")
        }
    }
}
