
import SwiftUI

struct OptimizerView: View {

    @StateObject private var optimizer = OptimizationService()

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    Text("GAME OPTIMIZER")
                        .font(.largeTitle.bold())

                    Text("Prepare your iPad before gaming.")
                        .foregroundStyle(.gray)

                    VStack(alignment: .leading, spacing: 10) {

                        HStack {

                            Text("Preparation progress")

                            Spacer()

                            Text(
                                "\(optimizer.completed.count)/\(optimizer.tasks.count)"
                            )
                            .foregroundStyle(PrismaticTheme.purple)
                        }

                        ProgressView(value: optimizer.progress)
                            .tint(PrismaticTheme.purple)
                    }
                    .padding()
                    .background(PrismaticTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                    ForEach(optimizer.tasks) { task in

                        Button {

                            optimizer.toggle(task)

                        } label: {

                            HStack(spacing: 14) {

                                Image(systemName: task.symbol)
                                    .font(.title2)
                                    .foregroundStyle(PrismaticTheme.purple)
                                    .frame(width: 35)

                                VStack(alignment: .leading, spacing: 5) {

                                    Text(task.title)
                                        .font(.headline)

                                    Text(task.description)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }

                                Spacer()

                                Image(
                                    systemName:
                                        optimizer.completed.contains(task.title)
                                        ? "checkmark.circle.fill"
                                        : "circle"
                                )
                                .foregroundStyle(
                                    optimizer.completed.contains(task.title)
                                    ? .green
                                    : .gray
                                )
                            }
                            .padding()
                            .background(PrismaticTheme.card)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .buttonStyle(.plain)
                    }

                    Text(
                        "These are preparation checks, not automatic system RAM cleaning."
                    )
                    .font(.caption)
                    .foregroundStyle(.gray)
                }
                .padding()
            }
            .background(PrismaticTheme.background)
            .foregroundStyle(.white)
            .navigationTitle("Optimizer")
        }
    }
}
