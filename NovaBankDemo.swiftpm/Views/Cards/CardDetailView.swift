import SwiftUI

struct CardDetailView: View {
    let card: BankCard
    @EnvironmentObject var appState: AppState

    private var liveCard: BankCard {
        appState.cards.first(where: { $0.id == card.id }) ?? card
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.l) {
                CardVisual(card: liveCard)

                HStack(spacing: Theme.Spacing.m) {
                    ActionButton(icon: liveCard.isBlocked ? "lock.open.fill" : "lock.fill",
                                 title: liveCard.isBlocked ? "Sblocca" : "Blocca") {
                        appState.toggleCardBlock(cardID: card.id)
                    }
                    ActionButton(icon: "gearshape.fill", title: "Impostazioni") {}
                    ActionButton(icon: "info.circle.fill", title: "Dettagli") {}
                }

                VStack(spacing: 0) {
                    DetailInfoRow(label: "Disponibilità", value: liveCard.availableLimit.asCurrency())
                    Divider()
                    DetailInfoRow(label: "Circuito", value: liveCard.circuit.rawValue)
                    Divider()
                    DetailInfoRow(label: "Scadenza", value: liveCard.expiry)
                    Divider()
                    DetailInfoRow(label: "Stato", value: liveCard.isBlocked ? "Bloccata" : "Attiva")
                }
                .background(Theme.Colors.surfaceSoft)
                .cornerRadius(Theme.Radius.card)
                .cardShadowStyle()

                Text("Dati carta interamente fittizi, generati per la demo")
                    .font(Theme.Fonts.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(Theme.Spacing.l)
        }
        .background(Color.white.ignoresSafeArea())
        .pageHeader(title: "Dettaglio carta", inline: true)
    }
}

private struct ActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: Theme.Spacing.s) {
                ZStack {
                    Circle()
                        .fill(Theme.Colors.incomeGreenSoft)
                        .frame(width: 48, height: 48)
                    Image(systemName: icon)
                        .foregroundColor(Theme.Colors.brandGreen)
                }
                Text(title)
                    .font(Theme.Fonts.caption)
                    .foregroundColor(Theme.Colors.textPrimary)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

private struct DetailInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.Colors.textSecondary)
            Spacer()
            Text(value)
                .font(Theme.Fonts.headline)
                .foregroundColor(Theme.Colors.textPrimary)
        }
        .padding(Theme.Spacing.l)
    }
}

#Preview {
    NavigationStack {
        CardDetailView(card: DemoData.initialCards()[0])
    }
    .environmentObject(AppState())
}
