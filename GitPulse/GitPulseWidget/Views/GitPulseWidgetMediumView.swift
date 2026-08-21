//
//  GitPulseWidgetMediumView.swift
//  GitPulse
//
//  Created by Manuel              on 19/08/2026.
//

import SwiftUI

struct GitPulseWidgetMediumView: View {

    let repository: GitRepository

    private var statusColor: Color {
        repository.isClean
            ? GitPulseColors.green
            : GitPulseColors.orange
    }

    private var statusText: String {
        repository.isClean
            ? "Clean"
            : "Changes"
    }

    private var statusIcon: String {
        repository.isClean
            ? "checkmark.circle"
            : "exclamationmark.circle"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // MARK: Header

            HStack(alignment: .center, spacing: 16) {

                GitPulseLogo()
                    .frame(width: 64, height: 64)

                VStack(alignment: .leading, spacing: 5) {

                    HStack(spacing: 8) {

                        Text(repository.projectName)
                            .font(
                                .system(
                                    size: 20,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(
                                GitPulseColors.primaryText
                            )
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)

                        Circle()
                            .fill(statusColor)
                            .frame(width: 8, height: 8)
                    }

                    Text(repository.branch)
                        .font(
                            .system(
                                size: 16,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    GitPulseColors.cyan,
                                    GitPulseColors.purple
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .lineLimit(1)
                        .truncationMode(.tail)
                }

                Spacer(minLength: 0)
            }

            Spacer(minLength: 20)

            // MARK: Divider

            Rectangle()
                .fill(Color.white.opacity(0.12))
                .frame(height: 1)

            Spacer(minLength: 16)

            // MARK: Status

            HStack(spacing: 10) {

                Image(systemName: statusIcon)
                    .font(
                        .system(
                            size: 20,
                            weight: .medium
                        )
                    )
                    .foregroundStyle(statusColor)

                Text(statusText)
                    .font(
                        .system(
                            size: 19,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(statusColor)

                Spacer(minLength: 0)
            }
        }
        .padding(20)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}
