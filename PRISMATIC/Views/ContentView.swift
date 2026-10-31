
import SwiftUI

struct ContentView: View {

    var body: some View {

        TabView {

            DashboardView()
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "house.fill"
                    )
                }

            GamesView()
                .tabItem {
                    Label(
                        "Games",
                        systemImage: "gamecontroller.fill"
                    )
                }

            OptimizerView()
                .tabItem {
                    Label(
                        "Optimize",
                        systemImage: "bolt.fill"
                    )
                }

            SettingsView()
                .tabItem {
                    Label(
                        "Settings",
                        systemImage: "gearshape.fill"
                    )
                }
        }
        .tint(PrismaticTheme.purple)
    }
}
