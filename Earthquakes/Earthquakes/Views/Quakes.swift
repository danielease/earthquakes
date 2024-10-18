//
//  ContentView.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-13.
//

import SwiftUI

struct Quakes: View {
    @EnvironmentObject var provider: QuakesProvider
    @State var isLoading = false
    
    @State var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(provider.quakes) { quake in
                    QuakeRow(quake: quake)
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle("Earthquakes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            editMode.toggle()
                        }
                    } label: {
                        editMode == .active ?
                        Text("Done").bold() :
                        Text("Edit")
                    }
                }
            }
            .environment(\.editMode, $editMode)
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

extension Quakes {
    func deleteQuakes(at offsets: IndexSet) {
        provider.quakes.remove(atOffsets: offsets)
    }
}

extension EditMode {
    mutating func toggle() {
        if self == .active {
            self = .inactive
        }
        else if self == .inactive {
            self = .active
        }
    }
}

#Preview {
    Quakes()
        .environmentObject(
            QuakesProvider(
                client: QuakeClient(
                    downloader: TestDownloader()
                )
            )
                           
        )
}
