
import SwiftUI

struct SettingsView: View {

    var body: some View {

        NavigationStack {

            Form {

                Section("About") {

                    HStack {
                        Text("App name")

                        Spacer()

                        Text("PRISMATIC")
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        Text("Version")

                        Spacer()

                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Device") {

                    HStack {
                        Text("Platform")

                        Spacer()

                        Text("iPadOS")
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        Text("Minimum OS")

                        Spacer()

                        Text("16.0")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Performance Limitations") {

                    Text(
                        "iOS does not permit third-party apps to force-clear " +
                        "system RAM, control other apps' CPU/GPU resources, " +
                        "or change their FPS settings."
                    )
                    .font(.footnote)
                }
            }
            .scrollContentBackground(.hidden)
            .background(PrismaticTheme.background)
            .foregroundStyle(.white)
            .navigationTitle("Settings")
        }
    }
}
