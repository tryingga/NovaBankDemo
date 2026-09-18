import SwiftUI
import UIKit

/// Sezione "Carte" della Home: elemento carta, promo aggiungi carta e
/// riepilogo "Analisi delle spese" (uscite/entrate del mese).
struct CardsSectionView: View {
    let cards: [BankCard]
    var onShowCards: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            CardsHeader(onShowCards: onShowCards)
                .frame(width: HomeDesign.width, height: HomeDesign.cardsHeaderHeight)

            CardItemRow(onOpen: onShowCards ?? {})
                .frame(width: HomeDesign.width, height: 175)

            Color.clear.frame(height: 12)

            AddCardPromoBox()
                .frame(width: HomeDesign.width, height: 170)

            Color.clear.frame(height: 28)

            SpendingAnalysisHeader()
                .frame(width: HomeDesign.width, height: 100)

            Color.clear.frame(height: 56)

            SpendingAnalysisBox()
                .frame(width: HomeDesign.width, height: 230)
        }
        .frame(width: HomeDesign.width, height: HomeDesign.cardsSectionHeight)
        .background(Color.white)
    }
}

/// Intestazione "Carte" con lo stile del titolo "Movimenti": titolo robusto,
/// link verde a destra e divider sotto.
private struct CardsHeader: View {
    var onShowCards: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("Carte")
                .font(.system(size: 45, weight: .regular))
                .foregroundColor(.black)
            Spacer(minLength: 0)
            Button(action: { onShowCards?() }) {
                HStack(spacing: 6) {
                    Text("Vai alla sezione")
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
            height: HomeDesign.cardsHeaderHeight,
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

/// Elemento carta: anteprima blu a sinistra, titolo/sottotitolo affiancati
/// (allineati manualmente allo stack, niente offset assoluti) e freccia a destra.
private struct CardItemRow: View {
    var onOpen: () -> Void

    var body: some View {
        Button(action: onOpen) {
            HStack(alignment: .top, spacing: 22) {
                Group {
                    if let cardImage = UIImage(named: "cartadebitoISP") {
                        Image(uiImage: cardImage)
                            .resizable()
                    } else {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(
                                LinearGradient(
                                    colors: [Theme.Colors.homeGradientStart, Theme.Colors.homeGradientEnd],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 96)
                .clipped()

                VStack(alignment: .leading, spacing: 10) {
                    Text("XME CARD PLUS MC PRENOTABILE")
                        .textCase(.uppercase)
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    Text("5167 **** **** 3231 - Debito")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Theme.Colors.novaGray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(.top, 6)

                Spacer(minLength: 8)

                Image(systemName: "chevron.right")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Color.black.opacity(0.55))
                    .frame(width: 30, height: 96, alignment: .center)
            }
            .padding(.top, 36)
            .padding(.leading, 27)
            .padding(.trailing, 27)
            .frame(width: HomeDesign.width, height: 175, alignment: .topLeading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

/// Box grigio chiaro "Scegli la carta più adatta a te" con pulsante "+ Aggiungi"
/// e illustrazione di carta a destra.
private struct AddCardPromoBox: View {
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Scegli la carta più adatta a te")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Button(action: {}) {
                    HStack(spacing: 8) {
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .semibold))
                        Text("Aggiungi")
                            .font(.system(size: 23, weight: .semibold))
                    }
                    .foregroundColor(Theme.Colors.novaGreen)
                }
                .buttonStyle(.plain)
            }
            Spacer(minLength: 8)
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "7B5CD6"), Color(hex: "4A3FAF")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(hex: "E8C54A"))
                    .frame(width: 24, height: 18)
                    .offset(x: -40, y: 4)
                Text("•••• 3231")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(.white)
                    .offset(x: -30, y: 32)
            }
            .frame(width: 150, height: 92)
            .rotationEffect(.degrees(-8))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 28)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "F5F6F8")))
        .padding(.horizontal, 27)
        .frame(width: HomeDesign.width, height: 170, alignment: .topLeading)
    }
}

/// Intestazione "Analisi delle spese" con lo stile del titolo "Movimenti".
private struct SpendingAnalysisHeader: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("Analisi delle spese")
                .font(.system(size: 45, weight: .regular))
                .foregroundColor(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Spacer(minLength: 0)
            Button(action: {}) {
                HStack(spacing: 6) {
                    Text("Vai alla sezione")
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
        .frame(width: HomeDesign.width, height: 120, alignment: .bottom)
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Theme.Colors.novaDivider)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
        }
    }
}

/// Box grigio chiaro con Uscite/Entrate del mese (valori oscurati).
private struct SpendingAnalysisBox: View {
    var body: some View {
        VStack(spacing: 0) {
            analysisRow(
                label: "Uscite del mese",
                value: "***** €",
                arrow: "arrow.down",
                circleColor: Color(hex: "FFCFD9"),
                arrowColor: .red
            )
            Color.clear.frame(height: 24)
            analysisRow(
                label: "Entrate del mese",
                value: "***** €",
                arrow: "arrow.up",
                circleColor: Color(hex: "D8F3DE"),
                arrowColor: .green
            )
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 34)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "F5F6F8")))
        .padding(.horizontal, 27)
        .frame(width: HomeDesign.width, height: 230, alignment: .topLeading)
    }

    private func analysisRow(label: String, value: String, arrow: String, circleColor: Color, arrowColor: Color) -> some View {
        HStack(spacing: 0) {
            Text(label)
                .font(.system(size: 24, weight: .light))
                .foregroundColor(.black)
            Spacer(minLength: 0)
            Text(value)
                .font(.system(size: 26, weight: .light))
                .foregroundColor(.black)
                .padding(.trailing, 18)
            ZStack {
                Circle()
                    .fill(circleColor)
                Image(systemName: arrow)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(arrowColor)
            }
            .frame(width: 52, height: 52)
        }
    }
}

#Preview {
    CardsSectionView(cards: DemoData.initialCards())
}