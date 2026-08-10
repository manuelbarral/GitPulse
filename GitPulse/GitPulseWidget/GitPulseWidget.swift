//
//  GitPulseWidget.swift
//  GitPulseWidget
//
//  Created by Manuel              on 08/08/2026.
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

    func getSnapshot(in context: Context, completion: @escaping (GitPulseEntry) -> ()) {
        let entry = makeSampleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [GitPulseEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = makeSampleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct GitPulseEntry: TimelineEntry {
    let date: Date
    let repository: GitRepository
}

struct GitPulseWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.repository.projectName)
                .font(.headline)

            Text(entry.repository.branch)
                .font(.subheadline)

            Text(entry.repository.lastCommit)
                .font(.caption)

            Text(entry.repository.isClean ? "Clean" : "Changes")
                .font(.caption2)
        }
    }
}

struct GitPulseWidget: Widget {
    let kind: String = "GitPulseWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            if #available(macOS 14.0, *) {
                GitPulseWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                GitPulseWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
