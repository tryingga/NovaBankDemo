import Foundation
import SwiftUI

/// Stato globale dell'app - dati esclusivamente locali, nessuna rete.
@MainActor
final class AppState: ObservableObject {

    // Login
    @Published var isLoggedIn: Bool = false
    @Published var loginError: String?

    // Dati profilo/conto
    @Published var profile: UserProfile = DemoData.profile
    @Published var account: Account = DemoData.mainAccount
    @Published var transactions: [Transaction] = DemoData.initialTransactions()
    @Published var cards: [BankCard] = DemoData.initialCards()

    // MARK: - Login

    func attemptLogin(username: String, password: String) {
        if username == DemoData.demoUsername && password == DemoData.demoPassword {
            loginError = nil
            withAnimation(.easeInOut(duration: 0.35)) {
                isLoggedIn = true
            }
        } else {
            loginError = "Credenziali non valide. Usa demo / demo123."
        }
    }

    func loginAsDemo() {
        attemptLogin(username: DemoData.demoUsername, password: DemoData.demoPassword)
    }

    func logout() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isLoggedIn = false
        }
    }

    // MARK: - Operazioni simulate

    /// Esegue un bonifico simulato: sottrae l'importo dal saldo e aggiunge un movimento.
    func performSimulatedTransfer(recipient: String, amount: Double, reason: String) {
        account.balance -= amount
        let newTransaction = Transaction(
            title: "Bonifico a \(recipient)",
            subtitle: reason.isEmpty ? "Bonifico simulato" : reason,
            amount: -amount,
            date: Date(),
            category: .altro
        )
        transactions.insert(newTransaction, at: 0)
    }

    /// Ricarica telefonica simulata.
    func performSimulatedTopUp(number: String, amount: Double) {
        account.balance -= amount
        let newTransaction = Transaction(
            title: "Ricarica telefonica",
            subtitle: "Numero \(number)",
            amount: -amount,
            date: Date(),
            category: .altro
        )
        transactions.insert(newTransaction, at: 0)
    }

    func toggleCardBlock(cardID: UUID) {
        guard let index = cards.firstIndex(where: { $0.id == cardID }) else { return }
        cards[index].isBlocked.toggle()
    }
}
