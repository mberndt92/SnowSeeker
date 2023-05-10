//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Maximilian Berndt on 2023/05/09.
//

import SwiftUI

struct ResortView: View {
    
    let resort: Resort
    
    @Environment (\.horizontalSizeClass) var sizeClass
    @Environment (\.dynamicTypeSize) var typeSize
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
//                    Image(systemName: "info.circle")
//                        .resizable()
//                        .frame(width: 32, height: 32)
//                        .foregroundColor(.black)
//                        .background(.white)
//                        .clipShape(Circle())
//                        .padding()
                        
                        
                    Text(resort.imageCredit)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.bottom, 8)
                        .padding(.trailing, 5)
                }
                
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 15) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 15) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                        
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    
//                    Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
//                        if favorites.contains(resort) {
//                            favorites.remove(resort)
//                        } else {
//                            favorites.add(resort)
//                        }
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility)  { _ in
        } message: { facility in
            Text(facility.description)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                } label: {
                    if favorites.contains(resort) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "heart")
                    }
                    
                }
            }
        }
        
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
        }
        .environmentObject(Favorites())
    }
}
