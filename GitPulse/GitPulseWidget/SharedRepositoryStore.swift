//
//  SharedRepositoryStore.swift
//  GitPulse
//
//  Created by Manuel              on 10/08/2026.
//

import Foundation

struct SharedRepositoryStore {
    
    private static let suiteName = "group.com.manuelbarral.GitPulse"
    private static let repositoryKey = "sharedRepository"
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults? = nil) {
        if let defaults {
            self.defaults = defaults
        } else {
            guard let defaults = UserDefaults(suiteName: Self.suiteName) else {
                fatalError("Unable to access shared App Group.")
            }

            self.defaults = defaults
        }
    }
    
    func save(_ repository: GitRepository) {
        do {
            let data = try JSONEncoder().encode(repository)
            defaults.set(data, forKey: Self.repositoryKey)
        } catch {
            print("Failed to save repository: \(error)")
        }
    }
    
    func load() -> GitRepository? {
        guard let data = defaults.data(forKey: Self.repositoryKey) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(GitRepository.self, from: data)
        } catch {
            print("Failed to load repository: \(error)")
            return nil
        }
    }
}
