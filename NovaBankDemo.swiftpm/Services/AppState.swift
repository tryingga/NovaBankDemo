import Foundation
import SwiftUI

/// Stato globale dell'app - dati esclusivamente locali, nessuna rete.
@MainActor
final class AppState: ObservableObject {

    // Login
    @Published var isLoggedIn: Bool = false
    @Published var loginError: String?
    @Published var isAuthenticatingFaceID: Bool = false

    // Dati profilo/conto
    @Published var profile: UserProfile = DemoData.profile
    @Published var account: Account = DemoData.mainAccount
    @Published var transactions: [Transaction] = DemoData.initialTransactions()
    @Published var cards: [BankCard] = DemoData.initialCards()

    // MARK: - Login

    /// Verifica il codice di sblocco numerico (demo, nessuna sicurezza reale).
    func attemptUnlock(code: String) {
        if code == DemoData.demoUnlockCode {
            loginError = nil
            withAnimation(.easeInOut(duration: 0.35)) {
                isLoggedIn = true
            }
        } else {
            loginError = "Codice non corretto."
        }
    }

    /// Simula l'avvio e l'esito di un riconoscimento Face ID (nessuna autenticazione biometrica reale).
    func simulateFaceIDAuthentication(onFailure: @escaping () -> Void) {
        isAuthenticatingFaceID = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [weak self] in
            guard let self else { return }
            self.isAuthenticatingFaceID = false
            // Nella demo il riconoscimento Face ID ha sempre successo.
            withAnimation(.easeInOut(duration: 0.35)) {
                self.isLoggedIn = true
            }
        }
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
