//
//  GitRepository.swift
//  GitPulse
//
//  Created by Manuel              on 09/08/2026.
//

import Foundation

struct GitRepository : Codable {
    let projectName: String
    let branch: String
    let lastCommit: String
    let isClean: Bool
}
