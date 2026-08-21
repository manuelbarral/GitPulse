//
//  GitPulseWidget.swift
//  GitPulseWidget
//
//  Created by Manuel on 08/08/2026.
//

import WidgetKit
import SwiftUI

private struct GitPulseWidgetView: View {

    let entry: GitPulseEntry

    @Environment(\.widgetFamily) private var family

    var body: some View {

        Group {
            switch family {

            case .systemMedium:
                GitPulseWidgetMediumView(
                    repository: entry.repository
                )

            case .systemExtraLarge:
                GitPulseWidgetExtraLargeView(
                    repository: entry.repository
                )

            default:
                GitPulseWidgetMediumView(
                    repository: entry.repository
                )
            }
        }
        .containerBackground(
            GitPulseColors.background,
            for: .widget
        )
    }
}

struct GitPulseWidget: Widget {

    let kind: String = "GitPulseWidget"

    var body: some WidgetConfiguration {

        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            GitPulseWidgetView(entry: entry)
        }
        .configurationDisplayName("GitPulse")
        .description("Monitor your Git repository.")
        .supportedFamilies([
            .systemMedium,
            .systemExtraLarge
        ])
    }
}
