import SwiftUI

extension UserProfile {
    var firstName: String {
        fullName.split(separator: " ").first.map(String.init) ?? fullName
    }
}

/// Grande area verde superiore della Home (0...830 px).
struct HeroSection: View {
    @EnvironmentObject var appState: AppState
    var onShowCards: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(
                colors: [Theme.Colors.homeGradientStart, Theme.Colors.homeGradientEnd],
                startPoint: .leading,
                endPoint: .trailing
            )
            SearchHelpView()
            HeroHeaderColumn(
                name: appState.profile.firstName,
                balanceText: appState.account.balance.novaAmountString(),
                onShowCards: onShowCards
            )
            QuickActionsStrip(onShowCards: onShowCards)
        }
        .frame(width: HomeDesign.width, height: HomeDesign.heroHeight)
        .background(
            LinearGradient(
                colors: [Theme.Colors.homeGradientStart, Theme.Colors.homeGradientEnd],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
    }
}

/// Colonna unica allineata a sinistra (x = 0): saluto, selezione prodotti,
/// patrimonio con importo e "Vai a conti". Tutte le righe condividono lo
/// stesso bordo sinistro per costruzione. Elementi di destra dentro il canvas.
struct HeroHeaderColumn: View {
    let name: String
    let balanceText: String
    var onShowCards: (() -> Void)? = nil
    @State private var isBalanceHidden = true

    private var wholePart: String {
        if isBalanceHidden { return "*******" }
        let trimmed = balanceText.trimmingCharacters(in: .whitespaces)
        if let commaIndex = trimmed.lastIndex(of: ",") {
            return String(trimmed[..<commaIndex])
        }
        if let euroIndex = trimmed.lastIndex(of: "€") {
            return String(trimmed[..<euroIndex]).trimmingCharacters(in: .whitespaces)
        }
        return trimmed
    }

    private var fractionPart: String {
        if isBalanceHidden { return "€" }
        let trimmed = balanceText.trimmingCharacters(in: .whitespaces)
        if let commaIndex = trimmed.lastIndex(of: ",") {
            return String(trimmed[commaIndex...])
        }
        return " €"
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                Color.clear.frame(height: 186)

                Text("Ciao \(name)")
                    .font(.system(size: 70, weight: .regular))
                    .foregroundColor(.white)
                    .frame(height: 84, alignment: .topLeading)

                Color.clear.frame(height: 42)

                HStack(alignment: .center, spacing: 0) {
                    Text("Tutti i prodotti selezionati")
                        .font(.system(size: 31, weight: .light))
                        .foregroundColor(.white)
                    Spacer(minLength: 0)
                    Button(action: {}) {
                        Text("Configura")
                            .font(.system(size: 25, weight: .regular))
                            .underline()
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                }
                .frame(height: 40, alignment: .center)
                .padding(.trailing, 11)

                Color.clear.frame(height: 85)

                Text("Patrimonio")
                    .font(.system(size: 30, weight: .light))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(height: 40, alignment: .bottomLeading)

                Color.clear.frame(height: 6)

                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(wholePart)
                        .font(.system(size: 64, weight: isBalanceHidden ? .light : .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text(fractionPart)
                        .font(.system(size: 48, weight: .light))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .multilineTextAlignment(.leading)
                .frame(height: 80, alignment: .topLeading)

                Color.clear.frame(height: 21)

                Button(action: { onShowCards?() }) {
                    HStack(spacing: 4) {
                        Text("Vai a conti")
                            .font(.system(size: 28, weight: .light))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 22, weight: .regular))
                    }
                    .foregroundColor(.white)
                }
                .buttonStyle(.plain)
                .frame(height: 40, alignment: .leading)

                Color.clear.frame(height: 0)
            }
            .padding(.leading, 16)

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isBalanceHidden.toggle()
                }
            } label: {
                VStack(spacing: 6) {
                    Image(systemName: isBalanceHidden ? "eye" : "eye.slash")
                        .font(.system(size: 26, weight: .regular))
                        .foregroundColor(.white)
                    Text(isBalanceHidden ? "Mostra" : "Nascondi")
                        .font(.system(size: 21, weight: .regular))
                        .foregroundColor(.white)
                }
                .frame(width: 120, height: 110)
            }
            .buttonStyle(.plain)
            .place(566, 505, 120, 110)
        }
        .frame(width: HomeDesign.width, height: 624, alignment: .topLeading)
    }
}

/// Cerca / Aiuto in alto a destra.
struct SearchHelpView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 6) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 28, weight: .regular))
                    .foregroundColor(.white)
                Text("Cerca")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.white)
            }
            .frame(width: 80, height: 96, alignment: .top)
            .offset(x: 554, y: 109)

            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 27, height: 27)
                    Text("?")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                }
                Text("Aiuto")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.white)
            }
            .frame(width: 80, height: 96, alignment: .top)
            .offset(x: 613, y: 109)
        }
        .frame(width: HomeDesign.width, height: 210)
    }
}

#Preview {
    HeroSection()
        .environmentObject(AppState())
}