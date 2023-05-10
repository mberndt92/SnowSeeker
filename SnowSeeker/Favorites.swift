//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Maximilian Berndt on 2023/05/10.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        if let data: [String] = UserDefaults.standard.object(forKey: saveKey) as? [String] {
            resorts = Set(data)
        } else {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        return resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    private func save() {
        UserDefaults.standard.set(Array(resorts), forKey: saveKey)
    }
}
