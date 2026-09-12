import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var showNewTransfer = false

    private var recentTransactions: [Transaction] {
        Array(appState.transactions.prefix(4))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.xl) {

                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Ciao,")
                                .font(Theme.Fonts.body)
                                .foregroundColor(Theme.Colors.textSecondary)
                            Text(appState.profile.fullName.components(separatedBy: " ").first ?? "")
                                .font(Theme.Fonts.title)
                                .foregroundColor(Theme.Colors.textPrimary)
                        }
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Theme.Colors.primary.opacity(0.1))
                                .frame(width: 40, height: 40)
                            Image(systemName: "bell.fill")
                                .foregroundColor(Theme.Colors.primary)
                        }
                    }

                    BalanceCard(accountName: appState.account.name, balance: appState.account.balance)

                    // Azioni rapide
                    HStack(spacing: Theme.Spacing.l) {
                        QuickAction(icon: "arrow.up.right", title: "Bonifico") {
                            showNewTransfer = true
                        }
                        QuickAction(icon: "qrcode", title: "Ricarica") {}
                        QuickAction(icon: "doc.text.fill", title: "Bollettino") {}
                        QuickAction(icon: "creditcard.fill", title: "Carte") {}
                    }

                    VStack(alignment: .leading, spacing: Theme.Spacing.m) {
                        SectionHeader(title: "Movimenti recenti", actionTitle: "Vedi tutti") {}
                        VStack(spacing: 0) {
                            ForEach(recentTransactions) { transaction in
                                NavigationLink(value: transaction) {
                                    TransactionRow(transaction: transaction)
                                }
                                .buttonStyle(.plain)
                                if transaction.id != recentTransactions.last?.id {
                                    Divider().background(Theme.Colors.divider)
                                }
                            }
                        }
                        .padding(Theme.Spacing.m)
                        .background(Theme.Colors.surface)
                        .cornerRadius(Theme.Radius.card)
                        .cardShadowStyle()
                    }
                }
                .padding(Theme.Spacing.l)
            }
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationBarHidden(true)
            .navigationDestination(for: Transaction.self) { transaction in
                MovementDetailView(transaction: transaction)
            }
            .sheet(isPresented: $showNewTransfer) {
                NewTransferView()
            }
        }
    }
}

private struct QuickAction: View {
    let icon: String
    let title: String
    let action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button(action: action) {
            VStack(spacing: Theme.Spacing.s) {
                ZStack {
                    Circle()
                        .fill(Theme.Colors.primary.opacity(0.08))
                        .frame(width: 52, height: 52)
                    Image(systemName: icon)
                        .foregroundColor(Theme.Colors.primary)
                        .font(.system(size: 18, weight: .medium))
                }
                Text(title)
                    .font(Theme.Fonts.caption)
                    .foregroundColor(Theme.Colors.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .scaleEffect(pressed ? 0.93 : 1)
        }
        .buttonStyle(.plain)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in withAnimation(.easeOut(duration: 0.15)) { pressed = true } }
                .onEnded { _ in withAnimation(.easeOut(duration: 0.15)) { pressed = false } }
        )
    }
}

#Preview {
    HomeView().environmentObject(AppState())
}
