//
//  GitRepository.swift
//  GitPulse
//
//  Created by Manuel on 09/08/2026.
//

import Foundation

enum GitRepositoryStatus: String, Codable {
    case clean
    case changes
    case behind
}

struct GitRepository: Codable {

    let projectName: String
    let branch: String

    let status: GitRepositoryStatus

    let lastCommit: String
    let lastCommitAuthor: String
    let lastCommitTime: String
    let lastCommitBranch: String

    let commitsAhead: Int
    let lastPush: String
    let updated: String

    var isClean: Bool {
        status == .clean
    }
}
