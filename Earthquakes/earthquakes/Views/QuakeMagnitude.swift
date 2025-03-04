/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The view which displays the magitude of an earthquake.
*/

import SwiftUI

struct QuakeMagnitude: View {
    var quake: Quake

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.black)
            .frame(width: 60, height: 40)
            .overlay {
                Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(quake.color)
            }
    }
}

struct QuakeMagnitude_Previews: PreviewProvider {
    static var previewQuake = Quake(magnitude: 1.0,
                                    place: "Shakey Acres",
                                    time: Date(timeIntervalSinceNow: -1000),
                                    code: "nc73649170",
                                    detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!,
                                    tsunami: 0)
    static var previews: some View {
        QuakeMagnitude(quake: previewQuake)
    }
}
