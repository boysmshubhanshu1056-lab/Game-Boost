
import SwiftUI

struct GamesView: View {

    private let launcher = GameLauncher()

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 18) {

                    Text("MY GAMES")
                        .font(.largeTitle.bold())

                    Text("Choose a game to launch.")
                        .foregroundStyle(.gray)

                    ForEach(Game.supported) { game in
                        gameCard(game)
                    }
                }
                .padding()
            }
            .background(PrismaticTheme.background)
            .foregroundStyle(.white)
            .navigationTitle("Game Library")
        }
    }

    private func gameCard(_ game: Game) -> some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack(spacing: 14) {

                Image(systemName: game.icon)
                    .font(.system(size: 30))
                    .foregroundStyle(PrismaticTheme.purple)
                    .frame(width: 60, height: 60)
                    .background(PrismaticTheme.background)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                VStack(alignment: .leading, spacing: 5) {

                    Text(game.name)
                        .font(.title3.bold())

                    Text(game.subtitle)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }

                Spacer()
            }

            Button {

                launcher.launch(game)

            } label: {

                Label(
                    "LAUNCH GAME",
                    systemImage: "play.fill"
                )
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(PrismaticTheme.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(PrismaticTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
