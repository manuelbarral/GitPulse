//
//  GitPulseTests.swift
//  GitPulseTests
//
//  Created by Manuel              on 08/08/2026.
//

import Foundation
import Testing
@testable import GitPulse

struct GitPulseTests {

    @Test
    func fetchRepositoryReturnsExpectedData() {
        let provider = GitRepositoryProvider()

        let repository = provider.fetchRepository()

        #expect(repository.projectName == "ARGOS")
        #expect(repository.branch == "feature/auth")
        #expect(repository.lastCommit == "Implement auth service")
        #expect(repository.isClean == true)
    }
    
    @Test
    func sharedRepositoryStoreSavesAndLoadsRepository() {
        let store = SharedRepositoryStore()

        let repository = GitRepository(
            projectName: "TestProject",
            branch: "main",
            lastCommit: "Test commit",
            isClean: true
        )

        store.save(repository)

        let loadedRepository = store.load()

        #expect(loadedRepository?.projectName == repository.projectName)
        #expect(loadedRepository?.branch == repository.branch)
        #expect(loadedRepository?.lastCommit == repository.lastCommit)
        #expect(loadedRepository?.isClean == repository.isClean)
    }
    
    @Test
    @MainActor
    func repositorySyncServiceStoresRepositoryFromProvider() {
        let provider = MockGitRepositoryProvider()
        let defaults = UserDefaults(
            suiteName: "GitPulseTests.RepositorySyncService"
        )!

        let store = SharedRepositoryStore(defaults: defaults)

        let service = RepositorySyncService(
            repositoryProvider: provider,
            store: store
        )

        service.sync()

        let repository = store.load()

        #expect(repository?.projectName == "GitPulse")
        #expect(repository?.branch == "main")
        #expect(repository?.lastCommit == "Test dependency injection")
        #expect(repository?.isClean == false)
    }
}
