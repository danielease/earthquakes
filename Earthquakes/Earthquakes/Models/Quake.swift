//
//  Quake.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-15.
//

import Foundation

struct Quake  {
    let magnitude: Double
    let place: String
    let time: Date
    let code: String
    let detail: URL
    let tsunami: Int
}
extension Quake: Identifiable {
    var id: String { code }
}

extension Quake: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case place
        case time
        case code
        case detail
        case tsunami
    }
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let magnitudeRaw = try? values.decode(Double.self, forKey: .magnitude)
        let placeRaw = try? values.decode(String.self, forKey: .place)
        let timeRaw = try? values.decode(Date.self, forKey: .time)
        let codeRaw = try? values.decode(String.self, forKey: .code)
        let detailRaw = try? values.decode(URL.self, forKey: .detail)
        let tsunamiRaw = try? values.decode(Int.self, forKey: .tsunami)
        
        guard let magnitude = magnitudeRaw,
              let place = placeRaw,
              let time = timeRaw,
              let code = codeRaw,
              let detail = detailRaw,
              let tsunami = tsunamiRaw
        else {
            throw QuakeError.missingData
        }
        
        self.magnitude = magnitude
        self.place = place
        self.time = time
        self.code = code
        self.detail = detail
        self.tsunami = tsunami
    }
    
}
