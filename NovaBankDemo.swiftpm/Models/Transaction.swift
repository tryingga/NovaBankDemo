import Foundation

enum TransactionCategory: String, CaseIterable {
    case spesa = "Spesa"
    case stipendio = "Stipendio"
    case intrattenimento = "Intrattenimento"
    case ristorazione = "Ristorazione"
    case trasporti = "Trasporti"
    case bollette = "Bollette"
    case altro = "Altro"

    var iconName: String {
        switch self {
        case .spesa: return "cart.fill"
        case .stipendio: return "banknote.fill"
        case .intrattenimento: return "play.tv.fill"
        case .ristorazione: return "fork.knife"
        case .trasporti: return "car.fill"
        case .bollette: return "bolt.fill"
        case .altro: return "square.grid.2x2.fill"
        }
    }
}

/// Movimento simulato (nessun dato reale).
struct Transaction: Identifiable, Hashable {
    let id: UUID
    var title: String
    var subtitle: String
    var amount: Double // positivo = entrata, negativo = uscita
    var date: Date
    var category: TransactionCategory

    init(id: UUID = UUID(), title: String, subtitle: String, amount: Double, date: Date, category: TransactionCategory) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.amount = amount
        self.date = date
        self.category = category
    }

    var isIncome: Bool { amount >= 0 }

    var formattedAmount: String {
        let sign = isIncome ? "+" : ""
        return sign + amount.asCurrency()
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = Locale(identifier: "it_IT")
        return formatter.string(from: date)
    }
}
