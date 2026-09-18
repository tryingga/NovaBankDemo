import SwiftUI

/// Pagina Investimenti: fascia verde con titolo grande sottile e frase di
/// apertura, poi la sezione "Fondi" con lo stesso stile delle sezioni della
/// Home (titoli 45 .regular / link 25 .light + divider 2px).
struct InvestmentsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ZStack(alignment: .topLeading) {
                        LinearGradient(
                            colors: [Theme.Colors.homeGradientStart, Theme.Colors.homeGradientEnd],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Investimenti")
                                .font(.system(size: 44, weight: .light))
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Per incominciare ad investire con noi,")
                                Text("scopri come fare")
                            }
                            .font(.system(size: 25, weight: .light))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.top, 26)
                        .padding(.bottom, 30)
                    }
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)

                    VStack(spacing: 0) {
                        HStack(alignment: .bottom) {
                            Text("Fondi")
                                .font(.system(size: 45, weight: .regular))
                                .foregroundColor(.black)
                            Spacer(minLength: 0)
                            Button(action: {}) {
                                HStack(spacing: 5) {
                                    Text("Visualizza tutti")
                                        .font(.system(size: 25, weight: .light))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 21, weight: .semibold))
                                }
                                .foregroundColor(Theme.Colors.brandGreen)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.bottom, 26)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(Theme.Colors.novaDivider)
                                .frame(height: 2)
                        }
                        .padding(.top, 18)

                        VStack(spacing: 0) {
                            FundRow(
                                icon: "person.fill",
                                iconColor: Color(hex: "1D4ED8"),
                                softColor: Color(hex: "DBEAFE"),
                                title: "Eurizon Open",
                                description: "La gamma di fondi per investire con una visione aperta al futuro in strumenti monetari, azionari, obbligazionari e anche in ETF"
                            )
                            FundRow(
                                icon: "mountain.2.fill",
                                iconColor: Color(hex: "D97706"),
                                softColor: Color(hex: "FEF3C7"),
                                title: "Eurizon Investo Smart",
                                description: "I fondi per investire online"
                            )
                            FundRow(
                                icon: "leaf.fill",
                                iconColor: Color(hex: "16A34A"),
                                softColor: Color(hex: "DCFCE7"),
                                title: "Fondi Tematici",
                                description: "Scegli i fondi comuni di investimento di Eurizon che investono in un mondo più sostenibile"
                            )
                            FundRow(
                                icon: "calendar",
                                iconColor: Color(hex: "DB2777"),
                                softColor: Color(hex: "FCE7F3"),
                                title: "Fondi a Scadenza",
                                description: "Cogli l'opportunità di investimenti che prevedono un orizzonte temporale predefinito"
                            )
                            FundRow(
                                icon: "laptopcomputer",
                                iconColor: Color(hex: "7C3AED"),
                                softColor: Color(hex: "EDE9FE"),
                                title: "Fondi PIR di Eurizon",
                                description: "Il tuo sostegno alle imprese italiane. Con i Piani Individuali di Risparmio puoi investire nelle piccole e medie imprese italiane e",
                                isLast: true
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Theme.Colors.surfaceSoft))
                        .padding(.top, 14)

                        Color.clear.frame(height: 40)
                    }
                    .padding(.horizontal, 18)
                    .background(Color.white)
                }
            }
            .background(Color.white)
            .pageHeader(title: "", inline: true)
        }
    }
}

/// Riga di un fondo: immagine quadrata a sinistra, titolo + descrizione al
/// centro e freccia a destra, separata dalla successiva da un divider sottile.
private struct FundRow: View {
    let icon: String
    let iconColor: Color
    let softColor: Color
    let title: String
    let description: String
    var isLast: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(softColor)
                Image(systemName: icon)
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(iconColor)
            }
            .frame(width: 76, height: 76)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                Text(description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(Theme.Colors.novaGray)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 8)

            Image(systemName: "chevron.right")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Theme.Colors.novaGrayLight)
                .padding(.top, 26)
        }
        .padding(.vertical, 14)
        .overlay(alignment: .bottom) {
            if !isLast {
                Rectangle()
                    .fill(Theme.Colors.novaDivider)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    InvestmentsView().environmentObject(AppState())
}