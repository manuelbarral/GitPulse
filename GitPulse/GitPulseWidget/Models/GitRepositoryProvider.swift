//
//  GitRepositoryProvider.swift
//  GitPulse
//
//  Created by Manuel              on 10/08/2026.
//

import Foundation

protocol GitRepositoryProviding {
    func fetchRepository() -> GitRepository
}

struct GitRepositoryProvider : GitRepositoryProviding {
    func fetchRepository() -> GitRepository {
        GitRepository(
            projectName: "ARGOS",
            branch: "feature/auth",
            lastCommit: "Implement auth service",
            isClean: true
        )
    }
}

struct MockGitRepositoryProvider: GitRepositoryProviding {
    func fetchRepository() -> GitRepository {
        GitRepository(
            projectName: "GitPulse",
            branch: "main",
            lastCommit: "Test dependency injection",
            isClean: false
        )
    }
}

