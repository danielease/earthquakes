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
    @State var selectMode: SelectMode = .inactive
    @State var selection: Set<String> = []
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                            if editMode == .active {
                                Button {
                                    selectMode.toggle()
                                    if selectMode.isActive {
                                        selection = Set(provider.quakes.map { $0.code })
                                    } else {
                                        selection = []
                                    }
                                } label: {
                                    Text(selectMode.isActive ? "Deslect All" : "Select All")
                                }
                            }
                        }
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
}

enum SelectMode {
    case active, inactive

    var isActive: Bool {
        self == .active
    }

    mutating func toggle() {
        switch self {
        case .active:
            self = .inactive
        case .inactive:
            self = .active
        }
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
