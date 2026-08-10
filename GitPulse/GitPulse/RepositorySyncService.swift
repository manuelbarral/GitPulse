//
//  RepositorySyncService.swift
//  GitPulse
//
//  Created by Manuel              on 10/08/2026.
//

import Foundation

struct RepositorySyncService {
    
    private let repositoryProvider: GitRepositoryProviding
    private let store: SharedRepositoryStore
    
    init(
        repositoryProvider: GitRepositoryProviding = GitRepositoryProvider(),
        store: SharedRepositoryStore = SharedRepositoryStore()
    ) {
        self.repositoryProvider = repositoryProvider
        self.store = store
    }
    
    func sync() {
        let repository = repositoryProvider.fetchRepository()
        store.save(repository)
    }
}
