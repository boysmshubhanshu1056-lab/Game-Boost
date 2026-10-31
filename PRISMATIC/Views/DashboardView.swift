
import SwiftUI

struct DashboardView: View {

    @StateObject private var memory = MemoryMonitor()
    @StateObject private var thermal = ThermalMonitor()
    @StateObject private var deviceStats = DeviceStatsMonitor()

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

                        HStack(spacing: 12) {
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
                        Text("SYSTEM RAM")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 14) {
                            if let total = deviceStats.totalRAMGB,
                               let used = deviceStats.usedRAMGB,
                               let available = deviceStats.availableRAMGB {

                                HStack(alignment: .firstTextBaseline) {
                                    Text("Estimated RAM in use")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)

                                    Spacer()

                                    Text(String(format: "%.2f GB", used))
                                        .font(.title2.bold())
                                        .foregroundStyle(.white)
                                }

                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Capsule()
                                            .fill(Color.white.opacity(0.10))

                                        Capsule()
                                            .fill(PrismaticTheme.gradient)
                                            .frame(
                                                width: geometry.size.width *
                                                CGFloat(min(used / total, 1))
                                            )
                                    }
                                }
                                .frame(height: 12)

                                HStack {
                                    Text("Total: \(total, specifier: "%.2f") GB")
                                    Spacer()
                                    Text("Available: \(available, specifier: "%.2f") GB")
                                }
                                .font(.caption)
                                .foregroundStyle(.gray)

                                Text("System-wide estimate. iPadOS manages memory automatically.")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)

                            } else {
                                unavailableText("RAM readings unavailable")
                            }
                        }
                        .padding()
                        .background(PrismaticTheme.card)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("DEVICE STORAGE")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 14) {
                            if let total = deviceStats.totalStorageGB,
                               let used = deviceStats.usedStorageGB,
                               let available = deviceStats.availableStorageGB {

                                HStack(alignment: .firstTextBaseline) {
                                    Text("Storage used")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)

                                    Spacer()

                                    Text(String(format: "%.1f GB", used))
                                        .font(.title2.bold())
                                        .foregroundStyle(.white)
                                }

                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Capsule()
                                            .fill(Color.white.opacity(0.10))

                                        Capsule()
                                            .fill(PrismaticTheme.gradient)
                                            .frame(
                                                width: geometry.size.width *
                                                CGFloat(min(used / total, 1))
                                            )
                                    }
                                }
                                .frame(height: 12)

                                HStack {
                                    Text("Total: \(total, specifier: "%.1f") GB")
                                    Spacer()
                                    Text("Free: \(available, specifier: "%.1f") GB")
                                }
                                .font(.caption)
                                .foregroundStyle(.gray)

                            } else {
                                unavailableText("Storage readings unavailable")
                            }
                        }
                        .padding()
                        .background(PrismaticTheme.card)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("QUICK ACTIONS")
                            .font(.headline)

                        Button {
                            memory.refresh()
                            thermal.update()
                            deviceStats.refresh()
                        } label: {
                            Label(
                                "Refresh Device Status",
                                systemImage: "arrow.clockwise"
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(PrismaticTheme.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
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
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .buttonStyle(.plain)

                        if let updated = deviceStats.lastUpdated {
                            Text("Last updated: \(updated.formatted(date: .omitted, time: .standard))")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding()
            }
            .background(PrismaticTheme.background)
            .foregroundStyle(.white)
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                refreshAll()
            }
        }
    }

    private func refreshAll() {
        memory.refresh()
        thermal.update()
        deviceStats.refresh()
    }

    private func unavailableText(_ message: String) -> some View {
        Text(message)
            .font(.subheadline)
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
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
