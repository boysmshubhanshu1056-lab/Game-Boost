
import Foundation

struct Game: Identifiable {

    let id: String
    let name: String
    let subtitle: String
    let icon: String
    let scheme: String
    let appStoreURL: String

    static let supported: [Game] = [

        Game(
            id: "roblox",
            name: "Roblox",
            subtitle: "Gaming Platform",
            icon: "gamecontroller.fill",
            scheme: "roblox://",
            appStoreURL:
                "https://apps.apple.com/app/roblox/id431946152"
        ),

        Game(
            id: "bgmi",
            name: "BGMI",
            subtitle: "Battlegrounds Mobile India",
            icon: "target",
            scheme: "bgmi://",
            appStoreURL:
                "https://apps.apple.com/in/app/battlegrounds-mobile-india/id1526436837"
        )
    ]
}
