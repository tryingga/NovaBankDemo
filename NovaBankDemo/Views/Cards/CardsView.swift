import SwiftUI

struct CardsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.Spacing.l) {
                    ForEach(appState.cards) { card in
                        NavigationLink(value: card) {
                            CardVisual(card: card)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(Theme.Spacing.l)
            }
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("Carte")
            .navigationDestination(for: BankCard.self) { card in
                CardDetailView(card: card)
            }
        }
    }
}

#Preview {
    CardsView().environmentObject(AppState())
}
