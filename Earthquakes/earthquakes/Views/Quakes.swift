//
//  ContentView.swift
//  Earthquakes
//
//  Created by Daniel on 2024-10-13.
//

import SwiftUI

struct Quakes: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var provider: QuakesProvider
    @State var isLoading = false
    
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var selection: Set<String> = []
    
    @State private var error: QuakeError?
    @State private var hasError = false
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(provider.quakes) { quake in
                    QuakeRow(quake: quake)
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .toolbar(content: toolbarContent)
            .environment(\.editMode, $editMode)
            .refreshable {
                await fetchQuakes()
            }
            .alert(isPresented: $hasError, error: error) {}
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
            lastUpdated = Date().timeIntervalSince1970
            self.hasError = false
        }
        catch {
            self.error = error as? QuakeError ?? .unexpectedError(error)
            self.hasError = true
        }
        
        isLoading = false
    }
}

extension Quakes {
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }
    
    func deleteQuakes(at offsets: IndexSet) {
        provider.quakes.remove(atOffsets: offsets)
    }
    
    func deleteQuakes(for codes: Set<String>) {
            var offsetsToDelete: IndexSet = []
            for (index, element) in provider.quakes.enumerated() {
                if codes.contains(element.code) {
                    offsetsToDelete.insert(index)
                }
            }
            deleteQuakes(at: offsetsToDelete)
            selection.removeAll()
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
