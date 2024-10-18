//
//  EarthquakesApp.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-13.
//

import SwiftUI

@main
struct EarthquakesApp: App {
    @StateObject var quakesProvider = QuakesProvider()
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakesProvider)
        }
    }
}
