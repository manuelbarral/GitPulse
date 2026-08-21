//
//  GitRepositoryProvider.swift
//  GitPulse
//
//  Created by Manuel on 10/08/2026.
//

import Foundation

protocol GitRepositoryProviding {

    func fetchRepository() -> GitRepository
}

struct GitRepositoryProvider: GitRepositoryProviding {

    func fetchRepository() -> GitRepository {

        GitRepository(
            projectName: "ARGOS",
            branch: "feature/auth",

            status: .clean,

            lastCommit: "Implement auth service",
            lastCommitAuthor: "Manuel",
            lastCommitTime: "2 minutes ago",
            lastCommitBranch: "main",

            commitsAhead: 3,
            lastPush: "5 min ago",
            updated: "Just now"
        )
    }
}

struct MockGitRepositoryProvider: GitRepositoryProviding {

    func fetchRepository() -> GitRepository {

        GitRepository(
            projectName: "GitPulse",
            branch: "main",

            status: .changes,

            lastCommit: "Test dependency injection",
            lastCommitAuthor: "Manuel",
            lastCommitTime: "Just now",
            lastCommitBranch: "main",

            commitsAhead: 0,
            lastPush: "Never",
            updated: "Just now"
        )
    }
}

