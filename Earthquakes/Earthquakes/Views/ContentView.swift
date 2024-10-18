//
//  ContentView.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-13.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var provider: QuakesProvider
    @State var isLoading = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(provider.quakes) { quake in
                    QuakeRow(quake: quake)
                }
            }
            .navigationTitle("Quakes")
        }
        .task {
            await fetchQuakes()
        }
        
    }
    
    //Async method to fetch quakes
    func fetchQuakes() async {
        isLoading = true
        
        do {
            try await provider.fetchQuakes()
        }
        catch {
            
        }
        
        isLoading = false
    }
}

#Preview {
    ContentView()
        .environmentObject(
            QuakesProvider(
                client: QuakeClient(
                    downloader: TestDownloader()
                )
            )
                           
        )
}
