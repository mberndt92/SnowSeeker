//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Maximilian Berndt on 2023/05/09.
//

import SwiftUI

// Example on how to e.g. force iPhones into stacked navigation view behavior, dropping the behavior of showing secondary view on launch
extension View {
    @ViewBuilder
    func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    
    enum SortOrder {
        case normal
        case alphabetical
        case country
    }
    
    @StateObject var favorites = Favorites()
    
    @State private var searchText = ""
    
    @State private var showingSortOrder = false
    @State private var sortOrder: SortOrder = .normal
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            List(sortedResorts(filteredResorts)) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSortOrder = true
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                    }
                }
            }
            
            WelcomeView()
        }
        .confirmationDialog("Sort order", isPresented: $showingSortOrder, actions: {
            Button("Normal") {
                sortOrder = .normal
            }
            
            Button("Alphabetical") {
                sortOrder = .alphabetical
            }
            
            Button("By country") {
                sortOrder = .country
            }
        })
//        .context
        .environmentObject(favorites)
//        .phoneOnlyNavigationView()
    }
    
    func sortedResorts(_ resorts: [Resort]) -> [Resort] {
        switch sortOrder {
        case .normal:
            return resorts
        case .alphabetical:
            return resorts.sorted(by: { $0.name < $1.name })
        case .country:
            return resorts.sorted(by: { $0.country < $1.country })
        }
    }
    
    private var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        }
        
        return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
