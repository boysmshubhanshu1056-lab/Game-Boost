
import SwiftUI

enum PrismaticTheme {

    static let background = Color(
        red: 0.035,
        green: 0.035,
        blue: 0.065
    )

    static let card = Color(
        red: 0.085,
        green: 0.085,
        blue: 0.135
    )

    static let purple = Color(
        red: 0.58,
        green: 0.35,
        blue: 1.0
    )

    static let secondary = Color.gray.opacity(0.75)

    static let gradient = LinearGradient(
        colors: [
            Color(red: 0.42, green: 0.20, blue: 0.95),
            Color(red: 0.20, green: 0.40, blue: 0.95)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
