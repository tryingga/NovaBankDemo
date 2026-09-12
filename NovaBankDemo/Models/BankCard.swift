import Foundation

enum CardCircuit: String {
    case visa = "VISA"
    case mastercard = "Mastercard"
}

/// Carta simulata - nessun numero reale, dati totalmente fittizi.
struct BankCard: Identifiable, Hashable {
    let id: UUID
    var holderName: String
    var lastFourDigits: String
    var circuit: CardCircuit
    var expiry: String // MM/AA
    var isBlocked: Bool
    var availableLimit: Double

    init(id: UUID = UUID(), holderName: String, lastFourDigits: String, circuit: CardCircuit, expiry: String, isBlocked: Bool = false, availableLimit: Double) {
        self.id = id
        self.holderName = holderName
        self.lastFourDigits = lastFourDigits
        self.circuit = circuit
        self.expiry = expiry
        self.isBlocked = isBlocked
        self.availableLimit = availableLimit
    }

    var maskedNumber: String {
        "•••• •••• •••• \(lastFourDigits)"
    }
}
