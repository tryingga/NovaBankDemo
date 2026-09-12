import SwiftUI

struct BalanceCard: View {
    let accountName: String
    let balance: Double
    @State private var appeared = false

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s) {
            HStack {
                Text(accountName)
                    .font(Theme.Fonts.body)
                    .foregroundColor(.white.opacity(0.8))
                Spacer()
                Image(systemName: "eye.fill")
                    .foregroundColor(.white.opacity(0.8))
            }

            Text(balance.asCurrency())
                .font(Theme.Fonts.amount)
                .foregroundColor(.white)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 6)

            HStack(spacing: Theme.Spacing.s) {
                Image(systemName: "arrow.up.right")
                    .font(.caption)
                Text("Saldo disponibile")
                    .font(Theme.Fonts.caption)
            }
            .foregroundColor(.white.opacity(0.75))
        }
        .padding(Theme.Spacing.l)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [Theme.Colors.primary, Theme.Colors.primary.opacity(0.85)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(Theme.Radius.card)
        .cardShadowStyle()
        .onAppear {
            withAnimation(.easeOut(duration: 0.4).delay(0.1)) {
                appeared = true
            }
        }
    }
}
