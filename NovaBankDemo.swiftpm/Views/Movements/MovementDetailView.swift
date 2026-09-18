import SwiftUI

struct MovementDetailView: View {
    let transaction: Transaction
    @State private var appeared = false

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.xl) {
                ZStack {
                    Circle()
                        .fill(transaction.isIncome ? Theme.Colors.incomeGreenSoft : Theme.Colors.expenseRedSoft)
                        .frame(width: 72, height: 72)
                    Image(systemName: transaction.category.iconName)
                        .font(.system(size: 28))
                        .foregroundColor(transaction.isIncome ? Theme.Colors.brandGreen : Theme.Colors.expenseRed)
                }
                .scaleEffect(appeared ? 1 : 0.7)
                .opacity(appeared ? 1 : 0)

                VStack(spacing: 4) {
                    Text(transaction.formattedAmount)
                        .font(Theme.Fonts.amount)
                        .foregroundColor(transaction.isIncome ? Theme.Colors.brandGreen : Theme.Colors.expenseRed)
                    Text(transaction.title)
                        .font(Theme.Fonts.headline)
                        .foregroundColor(Theme.Colors.textSecondary)
                }

                VStack(spacing: 0) {
                    DetailRow(label: "Descrizione", value: transaction.subtitle)
                    Divider()
                    DetailRow(label: "Categoria", value: transaction.category.rawValue)
                    Divider()
                    DetailRow(label: "Data", value: transaction.formattedDate)
                    Divider()
                    DetailRow(label: "Stato", value: "Completato")
                }
                .background(Theme.Colors.surfaceSoft)
                .cornerRadius(Theme.Radius.card)
                .cardShadowStyle()

                Text("Dati simulati a scopo dimostrativo")
                    .font(Theme.Fonts.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            .padding(Theme.Spacing.l)
        }
        .background(Color.white.ignoresSafeArea())
        .pageHeader(title: "Dettaglio", inline: true)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                appeared = true
            }
        }
    }
}

private struct DetailRow: View {
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
        MovementDetailView(transaction: DemoData.initialTransactions()[0])
    }
}
