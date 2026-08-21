//
//  GitPulseWidgetExtraLargeView.swift
//  GitPulse
//
//  Created by Manuel on 19/08/2026.
//

import SwiftUI

struct GitPulseWidgetExtraLargeView: View {

    let repository: GitRepository

    // MARK: - Status

    private var statusColor: Color {
        switch repository.status {
        case .clean:
            GitPulseColors.green
        case .changes:
            GitPulseColors.orange
        case .behind:
            Color.red
        }
    }

    private var statusText: String {
        switch repository.status {
        case .clean:
            "Clean"
        case .changes:
            "Changes"
        case .behind:
            "Behind"
        }
    }

    private var statusIcon: String {
        switch repository.status {
        case .clean:
            "checkmark.circle"
        case .changes:
            "exclamationmark.circle"
        case .behind:
            "arrow.down.circle"
        }
    }

    // MARK: - Body

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            // MARK: Header

            HStack(alignment: .center, spacing: 16) {

                GitPulseLogo()
                    .frame(width: 72, height: 72)

                VStack(alignment: .leading, spacing: 6) {

                    // Project name + status dot

                    HStack(spacing: 8) {

                        Text(repository.projectName)
                            .font(
                                .system(
                                    size: 22,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(
                                GitPulseColors.primaryText
                            )
                            .lineLimit(1)

                        Circle()
                            .fill(statusColor)
                            .frame(
                                width: 9,
                                height: 9
                            )
                    }

                    // Branch

                    HStack(
                        alignment: .center,
                        spacing: 8
                    ) {

                        GitPulseBranchIcon()
                            .frame(
                                width: 22,
                                height: 22
                            )

                        Text(repository.branch)
                            .font(
                                .system(
                                    size: 17,
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
                }

                Spacer(minLength: 0)

                // Status pill

                HStack(spacing: 6) {

                    Image(systemName: statusIcon)
                        .font(
                            .system(
                                size: 13,
                                weight: .medium
                            )
                        )

                    Text(statusText)
                        .font(
                            .system(
                                size: 14,
                                weight: .medium
                            )
                        )
                }
                .foregroundStyle(statusColor)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .overlay(
                    Capsule()
                        .stroke(
                            statusColor,
                            lineWidth: 1
                        )
                )
            }

            Spacer(minLength: 24)

            // MARK: Header Divider

            Rectangle()
                .fill(Color.white.opacity(0.12))
                .frame(height: 1)

            Spacer(minLength: 18)

            // MARK: Last Commit

            HStack(
                alignment: .center,
                spacing: 12
            ) {

                ZStack {

                    RoundedRectangle(
                        cornerRadius: 9
                    )
                    .fill(
                        Color.white.opacity(0.05)
                    )

                    GitPulseTerminal()
                        .frame(
                            width: 32,
                            height: 32
                        )
                }
                .frame(
                    width: 43,
                    height: 39
                )

                VStack(
                    alignment: .leading,
                    spacing: 3
                ) {

                    Text(repository.lastCommit)
                        .font(
                            .system(
                                size: 16,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            GitPulseColors.primaryText
                        )
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Text(
                        "\(repository.lastCommitTime) • by \(repository.lastCommitAuthor)"
                    )
                    .font(
                        .system(
                            size: 13,
                            weight: .regular
                        )
                    )
                    .foregroundStyle(
                        GitPulseColors.secondaryText
                    )
                    .lineLimit(1)
                    .truncationMode(.tail)
                }

                Spacer(minLength: 0)

                // Main branch

                Text(repository.lastCommitBranch)
                    .font(
                        .system(
                            size: 16,
                            weight: .medium
                        )
                    )
                    .foregroundStyle(
                        GitPulseColors.primaryText
                    )
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(
                                Color.white.opacity(0.07)
                            )
                    )
            }

            Spacer(minLength: 18)

            // MARK: Commit Divider

            Rectangle()
                .fill(Color.white.opacity(0.12))
                .frame(height: 1)

            Spacer(minLength: 18)

            // MARK: Repository Status

            HStack(spacing: 0) {

                // MARK: Working Tree

                VStack(spacing: 6) {

                    GitPulseStatusClean()
                        .frame(
                            width: 32,
                            height: 32
                        )

                    Text("Working Tree")
                        .font(
                            .system(
                                size: 13,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            GitPulseColors.secondaryText
                        )

                    Text(statusText)
                        .font(
                            .system(
                                size: 15,
                                weight: .semibold
                            )
                        )
                        .foregroundStyle(statusColor)
                }
                .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color.white.opacity(0.10))
                    .frame(
                        width: 1,
                        height: 82
                    )

                // MARK: Commits Ahead

                VStack(spacing: 6) {

                    GitPulseBranchIcon()
                        .frame(
                            width: 32,
                            height: 32
                        )

                    Text("Commits Ahead")
                        .font(
                            .system(
                                size: 13,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            GitPulseColors.secondaryText
                        )

                    Text(
                        "\(repository.commitsAhead)"
                    )
                    .font(
                        .system(
                            size: 15,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(
                        GitPulseColors.purple
                    )
                }
                .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color.white.opacity(0.10))
                    .frame(
                        width: 1,
                        height: 82
                    )

                // MARK: Last Push

                VStack(spacing: 6) {

                    GitPulsePush()
                        .frame(
                            width: 32,
                            height: 32
                        )

                    Text("Last Push")
                        .font(
                            .system(
                                size: 13,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            GitPulseColors.secondaryText
                        )

                    Text(repository.lastPush)
                        .font(
                            .system(
                                size: 15,
                                weight: .semibold
                            )
                        )
                        .foregroundStyle(
                            GitPulseColors.cyan
                        )
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color.white.opacity(0.10))
                    .frame(
                        width: 1,
                        height: 82
                    )

                // MARK: Updated

                VStack(spacing: 6) {

                    GitPulseUpdated()
                        .frame(
                            width: 32,
                            height: 32
                        )

                    Text("Updated")
                        .font(
                            .system(
                                size: 13,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            GitPulseColors.secondaryText
                        )

                    Text(repository.updated)
                        .font(
                            .system(
                                size: 15,
                                weight: .semibold
                            )
                        )
                        .foregroundStyle(
                            GitPulseColors.purple
                        )
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(24)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}
