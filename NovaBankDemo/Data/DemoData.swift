import Foundation

/// Tutti i dati "finti" dell'app sono definiti qui in un unico punto,
/// così sono facili da modificare per la demo scolastica.
enum DemoData {

    // MARK: - Credenziali demo
    static let demoUsername = "demo"
    static let demoPassword = "demo123"

    // MARK: - Profilo
    static let profile = UserProfile(
        fullName: "Mario Rossi",
        email: "mario.rossi@example.com",
        phone: "+39 333 123 4567"
    )

    // MARK: - Conto principale
    static let mainAccount = Account(
        name: "Conto Base",
        iban: "IT60 X054 2811 1010 0000 0123 456",
        balance: 4285.42
    )

    // MARK: - Movimenti
    static func initialTransactions() -> [Transaction] {
        let calendar = Calendar.current
        func daysAgo(_ n: Int) -> Date {
            calendar.date(byAdding: .day, value: -n, to: Date()) ?? Date()
        }

        return [
            Transaction(title: "Stipendio", subtitle: "Accredito mensile", amount: 1850.00, date: daysAgo(1), category: .stipendio),
            Transaction(title: "Supermercato Sole", subtitle: "Pagamento carta", amount: -47.80, date: daysAgo(2), category: .spesa),
            Transaction(title: "Streamly", subtitle: "Abbonamento mensile", amount: -12.99, date: daysAgo(3), category: .intrattenimento),
            Transaction(title: "Ristorante Da Luigi", subtitle: "Pagamento carta", amount: -38.50, date: daysAgo(5), category: .ristorazione),
            Transaction(title: "Bolletta Luce", subtitle: "Addebito automatico", amount: -64.20, date: daysAgo(7), category: .bollette),
            Transaction(title: "Trasporti Urbani", subtitle: "Ricarica abbonamento", amount: -35.00, date: daysAgo(9), category: .trasporti),
            Transaction(title: "Rimborso Anna", subtitle: "Bonifico ricevuto", amount: 20.00, date: daysAgo(12), category: .altro),
            Transaction(title: "Libreria Pagina", subtitle: "Pagamento carta", amount: -18.90, date: daysAgo(15), category: .altro)
        ]
    }

    // MARK: - Carte
    static func initialCards() -> [BankCard] {
        [
            BankCard(holderName: "Mario Rossi", lastFourDigits: "4821", circuit: .visa, expiry: "09/28", availableLimit: 1200.00),
            BankCard(holderName: "Mario Rossi", lastFourDigits: "7734", circuit: .mastercard, expiry: "03/27", availableLimit: 500.00)
        ]
    }
}
