//
//  QuakesProvider.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-17.
//

import Foundation

class QuakesProvider : ObservableObject {
    
    @Published var quakes: [Quake] = []
    
    let client: QuakeClient
    
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}
