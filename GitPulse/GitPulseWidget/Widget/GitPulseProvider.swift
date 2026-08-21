//
//  GitPulseProvider.swift
//  GitPulse
//
//  Created by Manuel              on 19/08/2026.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    private let repositoryProvider: GitRepositoryProviding
    private let store = SharedRepositoryStore()

    init(
        repositoryProvider: GitRepositoryProviding = GitRepositoryProvider()
    ) {
        self.repositoryProvider = repositoryProvider
    }

    private func makeSampleEntry(date: Date) -> GitPulseEntry {
        let repository = store.load() ?? repositoryProvider.fetchRepository()

        return GitPulseEntry(
            date: date,
            repository: repository
        )
    }

    func placeholder(in context: Context) -> GitPulseEntry {
        makeSampleEntry(date: Date())
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (GitPulseEntry) -> ()
    ) {
        let entry = makeSampleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<GitPulseEntry>) -> ()
    ) {
        var entries: [GitPulseEntry] = []

        let currentDate = Date()

        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(
                byAdding: .hour,
                value: hourOffset,
                to: currentDate
            )!

            let entry = makeSampleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(
            entries: entries,
            policy: .atEnd
        )

        completion(timeline)
    }
}
