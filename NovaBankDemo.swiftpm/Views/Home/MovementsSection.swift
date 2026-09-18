import SwiftUI

extension Double {
    /// Formatta un importo in stile Nova: "-9,99 €" / "1.010,39 €".
    func novaAmountString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "it_IT")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        let absValue = formatter.string(from: NSNumber(value: abs(self))) ?? "0,00"
        let sign = self < 0 ? "-" : ""
        return "\(sign)\(absValue) €"
    }
}

/// Movimento della lista Home: dati di sola visualizzazione, fedeli allo screenshot.
struct HomeMovement: Identifiable {
    let id: UUID
    let transaction: Transaction
    var status: String?

    init(transaction: Transaction, status: String? = nil) {
        self.id = UUID()
        self.transaction = transaction
        self.status = status
    }

    var dateLabel: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(transaction.date) { return "Oggi" }
        if calendar.isDateInYesterday(transaction.date) { return "Ieri" }
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = Locale(identifier: "it_IT")
        return formatter.string(from: transaction.date)
    }

    var displayName: String {
        transaction.title
    }

    var accountLabel: String {
        transaction.subtitle.isEmpty ? "Conto 1000/00018760" : transaction.subtitle
    }

    var amountText: String {
        transaction.amount.novaAmountString()
    }

    var amountWhole: String {
        let trimmed = amountText.trimmingCharacters(in: .whitespaces)
        guard let commaIndex = trimmed.lastIndex(of: ",") else { return trimmed }
        return String(trimmed[..<commaIndex])
    }

    var amountFraction: String {
        let trimmed = amountText.trimmingCharacters(in: .whitespaces)
        guard let commaIndex = trimmed.lastIndex(of: ",") else { return "" }
        return String(trimmed[commaIndex...])
    }

    var iconName: String {
        if status != nil { return "fork.knife" }
        return "eurosign"
    }

    var circleColor: Color {
        if status != nil { return Theme.Colors.novaLilac }
        return circleColor(for: transaction.category)
    }

    var nameIsTwoLines: Bool {
        displayName.contains("\n")
    }

    private func circleColor(for category: TransactionCategory) -> Color {
        switch category {
        case .spesa: return Theme.Colors.novaLilac
        case .ristorazione: return Theme.Colors.novaBeige
        case .stipendio: return Color(hex: "E5F1E0")
        case .intrattenimento: return Color(hex: "EAE9F8")
        case .trasporti: return Color(hex: "E6EFF7")
        case .bollette: return Color(hex: "F9EAE6")
        case .altro: return Color(hex: "F0EDEA")
        }
    }
}

/// Intestazione "Movimenti" + lista delle transazioni.
struct MovementsSectionView: View {
    let movements: [HomeMovement]
    var onShowAll: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            MovementsHeader(onShowAll: onShowAll)
                .frame(width: HomeDesign.width, height: HomeDesign.movHeaderHeight)
            ForEach(movements) { movement in
                MovementRow(movement: movement)
            }
        }
        .background(Color.white)
    }
}

/// Intestazione della sezione: titolo, "Visualizza tutti >", divider.
struct MovementsHeader: View {
    var onShowAll: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("Movimenti")
                .font(.system(size: 45, weight: .regular))
                .foregroundColor(.black)

            Spacer(minLength: 0)

            Button(action: { onShowAll?() }) {
                HStack(spacing: 6) {
                    Text("Visualizza tutti")
                        .font(.system(size: 25, weight: .light))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundColor(Theme.Colors.novaGreen)
                }
                .foregroundColor(Theme.Colors.novaGreen)
            }
            .buttonStyle(.plain)
        }
        .padding(.leading, 27)
        .padding(.trailing, 27)
        .padding(.bottom, 26)
        .frame(
            width: HomeDesign.width,
            height: HomeDesign.movHeaderHeight,
            alignment: .bottom
        )
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Theme.Colors.novaDivider)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
        }
    }
}

/// Riga di movimento con icona circolare, dati e importo.
struct MovementRow: View {
    let movement: HomeMovement

    private var nameHeight: CGFloat {
        movement.nameIsTwoLines ? 76 : 40
    }

    private var accountY: CGFloat {
        72 + nameHeight + 8
    }

    var body: some View {
        NavigationLink(value: movement.transaction) {
            ZStack(alignment: .topLeading) {
                Circle()
                    .fill(movement.circleColor)
                    .place(26, 52, 80, 80)

                Image(systemName: movement.iconName)
                    .font(.system(size: movement.status == nil ? 32 : 34, weight: .light))
                    .foregroundColor(.black)
                    .place(47, 74, 38, 38)

                Text(movement.dateLabel)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Theme.Colors.novaGray)
                    .place(126, 30, 260, 34)

                Text(movement.displayName)
                    .font(.system(size: 28, weight: .light))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .place(126, 72, 330, nameHeight)

                Text(movement.accountLabel)
                    .font(.system(size: 21, weight: .regular))
                    .foregroundColor(Theme.Colors.novaGrayLight)
                    .place(126, accountY, 330, 28)

                if let status = movement.status {
                    Text(status)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Theme.Colors.novaBlue)
                        .frame(width: 249, height: 24, alignment: .trailing)
                        .offset(x: 430, y: 30)
                }

                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Spacer(minLength: 0)
                    Text(movement.amountWhole)
                        .font(.system(size: 28, weight: .regular))
                        .foregroundColor(.black)
                    Text(movement.amountFraction)
                        .font(.system(size: 23, weight: .light))
                        .foregroundColor(.black)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color.black.opacity(0.55))
                }
                .frame(width: 249, height: 34)
                .offset(x: 410, y: 72)

                Rectangle()
                    .fill(Theme.Colors.novaDivider)
                    .frame(width: HomeDesign.width, height: 2)
                    .offset(x: 0, y: 202)
            }
            .frame(width: HomeDesign.width, height: HomeDesign.rowHeight)
            .background(Color.white)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        VStack(spacing: 0) {
            MovementsSectionView(
                movements: DemoData.initialTransactions()
                    .prefix(3)
                    .enumerated()
                    .map { index, transaction in
                        HomeMovement(transaction: transaction, status: index == 0 ? "NON CONTABILIZZATO" : nil)
                    }
            )
        }
    }
}