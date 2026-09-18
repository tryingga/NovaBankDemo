import Foundation

/// Tutti i dati "finti" dell'app sono definiti qui in un unico punto,
/// così sono facili da modificare per la demo scolastica.
enum DemoData {

    // MARK: - Credenziali demo
    static let demoUsername = "demo"
    static let demoPassword = "demo123"

    /// Codice di sblocco numerico usato dalla schermata di login (Face ID simulato + fallback a codice).
    static let demoUnlockCode = "0907"

    // MARK: - Profilo
    static let profile = UserProfile(
        fullName: "Pavel Farukov",
        email: "pavelsovietico@gmail.com",
        phone: "+39 333 123 4567"
    )

    // MARK: - Conto principale
    static let mainAccount = Account(
        name: "Conto 1000/00018760",
        iban: "IT60 X054 2811 1010 0000 0123 456",
        balance: 2386472.23
    )

    // MARK: - Movimenti
    static func initialTransactions() -> [Transaction] {
        let calendar = Calendar.current
        func daysAgo(_ n: Int) -> Date {
            calendar.date(byAdding: .day, value: -n, to: Date()) ?? Date()
        }

        return [
            Transaction(title: "Centro Iguazu' Don Luigi Or", subtitle: "Conto 1000/00018760", amount: -9.99, date: daysAgo(0), category: .spesa),
            Transaction(title: "Farmagora' Peseggia", subtitle: "Conto 1000/00018760", amount: -39.98, date: daysAgo(1), category: .ristorazione),
            Transaction(title: "Pagamento Pos", subtitle: "Abbonamento mensile", amount: -12.99, date: daysAgo(1), category: .intrattenimento),
            Transaction(title: "Supermercato Sole", subtitle: "Pagamento carta", amount: -47.80, date: daysAgo(2), category: .spesa),
            Transaction(title: "Ristorante Da Luigi", subtitle: "Pagamento carta", amount: -38.50, date: daysAgo(3), category: .ristorazione),
            Transaction(title: "Bolletta Luce", subtitle: "Addebito automatico", amount: -64.20, date: daysAgo(5), category: .bollette),
            Transaction(title: "Ricarica Telefonica", subtitle: "Promozione operatore", amount: -10.00, date: daysAgo(6), category: .altro),
            Transaction(title: "Trasporti Urbani", subtitle: "Ricarica abbonamento", amount: -35.00, date: daysAgo(7), category: .trasporti),
            Transaction(title: "Stipendio", subtitle: "Accredito mensile", amount: 1850.00, date: daysAgo(8), category: .stipendio)
        ]
    }

    // MARK: - Carte
    static func initialCards() -> [BankCard] {
        [
            BankCard(holderName: "Pavel Farukov", lastFourDigits: "4821", circuit: .visa, expiry: "09/28", availableLimit: 1200.00),
            BankCard(holderName: "Pavel Farukov", lastFourDigits: "7734", circuit: .mastercard, expiry: "03/27", availableLimit: 500.00)
        ]
    }
}
