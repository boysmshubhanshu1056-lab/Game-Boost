
import SwiftUI
import UIKit

final class GameLauncher {

    func launch(_ game: Game) {

        guard let url = URL(string: game.scheme) else {
            return
        }

        UIApplication.shared.open(
            url,
            options: [:]
        ) { success in

            if !success,
               let storeURL = URL(string: game.appStoreURL) {

                UIApplication.shared.open(storeURL)
            }
        }
    }
}
