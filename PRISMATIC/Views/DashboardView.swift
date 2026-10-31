
import SwiftUI

struct DashboardView: View {

    @StateObject private var memory = MemoryMonitor()
    @StateObject private var thermal = ThermalMonitor()

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 22) {

                    VStack(alignment: .leading, spacing: 5) {

                        Text("PRISMATIC")
                            .font(.system(size: 32, weight: .black))
                            .foregroundStyle(PrismaticTheme.purple)

                        Text("YOUR GAMING COMMAND CENTER")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }

                    VStack(alignment: .leading, spacing: 12) {

                        Text("DEVICE STATUS")
                            .font(.headline)

                        HStack {

                            statusCard(
                                "App Memory",
                                value: String(
                                    format: "%.1f MB",
                                    memory.usedMemoryMB
                                ),
                                symbol: "memorychip"
                            )

                            statusCard(
                                "Thermal",
                                value: thermal.status,
                                symbol: "thermometer"
                            )
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {

                        Text("QUICK ACTIONS")
                            .font(.headline)

                        Button {

                            memory.refresh()
                            thermal.update()

                        } label: {

                            Label(
                                "Refresh Device Status",
                                systemImage: "arrow.clockwise"
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(PrismaticTheme.gradient)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 14)
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink(destination: GamesView()) {

                            Label(
                                "Open Game Library",
                                systemImage: "gamecontroller.fill"
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(PrismaticTheme.card)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 14)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .background(PrismaticTheme.background)
            .foregroundStyle(.white)
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {

                memory.refresh()
                thermal.update()
            }
        }
    }

    private func statusCard(
        _ title: String,
        value: String,
        symbol: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Image(systemName: symbol)
                .font(.title2)
                .foregroundStyle(PrismaticTheme.purple)

            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)

            Text(value)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(PrismaticTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
