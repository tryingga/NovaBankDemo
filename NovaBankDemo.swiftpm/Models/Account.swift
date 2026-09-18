import Foundation

/// Rappresenta un conto/prodotto finanziario simulato.
struct Account: Identifiable, Hashable {
    let id: UUID
    var name: String
    var iban: String
    var balance: Double

    init(id: UUID = UUID(), name: String, iban: String, balance: Double) {
        self.id = id
        self.name = name
        self.iban = iban
        self.balance = balance
    }

    var formattedBalance: String {
        balance.asCurrency()
    }
}

extension Double {
    /// Formatta un importo come valuta EUR, es. "€ 4.285,42"
    func asCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "€ "
        formatter.locale = Locale(identifier: "it_IT")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "€ 0,00"
    }
}
