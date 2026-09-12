import SwiftUI

struct CardVisual: View {
    let card: BankCard

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.l) {
            HStack {
                Text("Nova Bank")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
                Text(card.circuit.rawValue)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
            }

            Spacer()

            Text(card.maskedNumber)
                .font(.system(size: 18, weight: .medium, design: .monospaced))
                .foregroundColor(.white)
                .kerning(1.5)

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("INTESTATARIO")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                    Text(card.holderName.uppercased())
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("SCADENZA")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                    Text(card.expiry)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(Theme.Spacing.l)
        .frame(height: 190)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: card.isBlocked
                    ? [Color.gray, Color.gray.opacity(0.7)]
                    : [Theme.Colors.primary, Color(hex: "173F7A")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(Theme.Radius.card)
        .cardShadowStyle()
        .overlay(alignment: .topTrailing) {
            if card.isBlocked {
                Text("BLOCCATA")
                    .font(.system(size: 10, weight: .bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Theme.Colors.negative)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .padding(10)
            }
        }
    }
}
