import SwiftUI

struct PaymentsView: View {
    @State private var showNewTransfer = false
    @State private var showTopUp = false
    @State private var showBillPay = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.Spacing.l) {
                    PaymentOptionCard(
                        icon: "arrow.up.right.circle.fill",
                        title: "Bonifico",
                        subtitle: "Invia denaro simulato a un beneficiario",
                        color: Theme.Colors.primary
                    ) { showNewTransfer = true }

                    PaymentOptionCard(
                        icon: "wifi",
                        title: "Ricarica telefonica",
                        subtitle: "Ricarica simulata di un numero di telefono",
                        color: Theme.Colors.accent
                    ) { showTopUp = true }

                    PaymentOptionCard(
                        icon: "doc.text.fill",
                        title: "Bollettino",
                        subtitle: "Paga un bollettino simulato",
                        color: Color(hex: "8B5CF6")
                    ) { showBillPay = true }
                }
                .padding(Theme.Spacing.l)
            }
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("Pagamenti")
            .sheet(isPresented: $showNewTransfer) { NewTransferView() }
            .sheet(isPresented: $showTopUp) { TopUpView() }
            .sheet(isPresented: $showBillPay) {
                OperationSuccessView(title: "Bollettino pagato", subtitle: "Operazione simulata completata con successo.")
            }
        }
    }
}

private struct PaymentOptionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.m) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(color.opacity(0.12))
                        .frame(width: 52, height: 52)
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 20))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(Theme.Fonts.headline)
                        .foregroundColor(Theme.Colors.textPrimary)
                    Text(subtitle)
                        .font(Theme.Fonts.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Theme.Colors.textSecondary)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(Theme.Spacing.l)
            .background(Theme.Colors.surface)
            .cornerRadius(Theme.Radius.card)
            .cardShadowStyle()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PaymentsView().environmentObject(AppState())
}
