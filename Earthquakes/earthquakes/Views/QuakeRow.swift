//
//  QuakeRow.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-17.
//

import SwiftUI

struct QuakeRow: View {
    let quake: Quake
    var body: some View {
        HStack(alignment: .top) {
            QuakeMagnitude(quake: quake)
            VStack(alignment: .leading) {
                Text(quake.place)
                    .font(.headline)
                    .fontWeight(.medium)
                Text("\(quake.time.formatted(.relative(presentation: .named)))")
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let quake = Quake(
        magnitude: 0.34,
        place: "5km NW of The Geysers, CA",
        time: Date(timeIntervalSince1970: 1636129710550 / 1000),
        code: "73649170",
        detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!,
        tsunami: 0
    )
    QuakeRow(quake: quake)
}
