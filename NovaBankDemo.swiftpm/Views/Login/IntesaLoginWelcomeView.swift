import SwiftUI
import UIKit

/// Schermata iniziale stile Intesa Sanpaolo (partner di Milano Cortina 2026):
/// header con loghi partner, "Ciao Pavel" + pulsante capsule "Entra", footer scuro
/// con prelievo cardless, BANCOMAT Pay® ed Emergenze.
struct IntesaLoginWelcomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var activeFooter: FooterAction?
    @State private var logoLoaded = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Theme.Colors.intesaGradientTop, Theme.Colors.intesaGradientBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            welcomeContent
        }
        .sheet(item: $activeFooter) { footer in
            footerSheet(for: footer)
        }
    }

    // MARK: - Contenuto

    private var welcomeContent: some View {
        VStack(spacing: 0) {
            header
            Spacer()
            centerSection
            Spacer()
            footer
        }
    }

    // MARK: - Header

    private var header: some View {
        bankLogoBlock
            .frame(maxWidth: .infinity)
            .padding(.top, 34)
    }

    private var bankLogoBlock: some View {
        VStack(spacing: 8) {
            ZStack {
                if let image = loadLogoImage() {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .opacity(logoLoaded ? 1 : 0)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.3)) {
                                logoLoaded = true
                            }
                        }
                }
            }

            Text("BANKING PREMIUM PARTNER")
                .font(.system(size: 9, weight: .semibold))
                .kerning(1.6)
                .foregroundColor(.white.opacity(0.92))
        }
    }

    // MARK: - Sezione centrale

    private var centerSection: some View {
        VStack(spacing: 24) {
            Text("Ciao Pavel")
                .font(.system(size: 32, weight: .light))
                .foregroundColor(.white)

            Button {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                withAnimation(.easeInOut(duration: 0.35)) {
                    appState.isLoggedIn = true
                }
            } label: {
                Text("Entra")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(Theme.Colors.intesaGreen)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(PressableOpacityStyle())
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Footer

    private var footer: some View {
        VStack(spacing: 12) {
            HStack(spacing: 10) {
                footerPill(icon: "banknote", title: "Prelievo Cardless") {
                    activeFooter = .cardless
                }
                footerPill(icon: "creditcard.fill", title: "BANCOMAT Pay®") {
                    activeFooter = .bancomat
                }
            }

            Button {
                activeFooter = .emergenze
            } label: {
                Text("Emergenze")
                    .font(.system(size: 13, weight: .light))
                    .underline()
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 4)
        }
        .padding(.horizontal, 14)
        .padding(.top, 14)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity)
    }

    private func footerPill(icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            action()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                Text(title)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 42)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }

    // MARK: - Modali

    private enum FooterAction: String, Identifiable {
        case cardless
        case bancomat
        case emergenze

        var id: String { rawValue }
    }

    @ViewBuilder
    private func footerSheet(for footer: FooterAction) -> some View {
        IntesaActionSheet(
            icon: sheetIcon(for: footer),
            title: sheetTitle(for: footer),
            message: sheetMessage(for: footer),
            primaryAction: footer == .emergenze ? "Blocca la mia carta" : nil,
            onPrimary: {
                if footer == .emergenze {
                    if let firstCard = appState.cards.first {
                        appState.toggleCardBlock(cardID: firstCard.id)
                    }
                    activeFooter = nil
                }
            },
            onSecondary: {
                activeFooter = nil
            }
        )
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }

    private func sheetIcon(for footer: FooterAction) -> String {
        switch footer {
        case .cardless: return "banknote"
        case .bancomat: return "wave.3.right"
        case .emergenze: return "exclamationmark.shield.fill"
        }
    }

    private func sheetTitle(for footer: FooterAction) -> String {
        switch footer {
        case .cardless: return "Prelievo Cardless"
        case .bancomat: return "BANCOMAT Pay®"
        case .emergenze: return "Emergenze"
        }
    }

    private func sheetMessage(for footer: FooterAction) -> String {
        switch footer {
        case .cardless:
            return "Genera un codice per prelevare da un ATM compatibile senza carta, direttamente dal tuo telefono."
        case .bancomat:
            return "Paga nei negozi convenzionati tramite BANCOMAT Pay®: basta il numero di cellulare per inviare o ricevere denaro in tempo reale."
        case .emergenze:
            return "Blocca la carta in caso di smarrimento o furto. Nella demo puoi bloccare la tua carta principale."
        }
    }

    // MARK: - Logo

    private func loadLogoImage() -> UIImage? {
        if let named = UIImage(named: "IntesaSanpaolologologotype") {
            return named
        }
        for subdirectory in [nil, "Resources", "Components"] {
            if let url = Bundle.main.url(
                forResource: "IntesaSanpaolologologotype",
                withExtension: "png",
                subdirectory: subdirectory
            ), let image = UIImage(contentsOfFile: url.path) {
                return image
            }
        }
        return nil
    }
}

// MARK: - Pulsanti e fogli modali

/// Inhibisce il comportamento predefinito di Button cambiando scala/opacità alla pressione.
struct PressableOpacityStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.88 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

/// Foglio informativo condiviso per le azioni del footer.
struct IntesaActionSheet: View {
    let icon: String
    let title: String
    let message: String
    var primaryAction: String?
    var onPrimary: (() -> Void)?
    var onSecondary: (() -> Void)?

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 34, weight: .semibold))
                .foregroundColor(Theme.Colors.intesaGreen)
                .padding(.top, 18)

            Text(title)
                .font(Theme.Fonts.title)
                .foregroundColor(Theme.Colors.textPrimary)

            Text(message)
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)

            VStack(spacing: 12) {
                if let primaryAction {
                    Button {
                        onPrimary?()
                    } label: {
                        Text(primaryAction)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .background(Theme.Colors.intesaGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                }

                Button {
                    onSecondary?()
                } label: {
                    Text("Chiudi")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Theme.Colors.textSecondary)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Theme.Colors.background)
    }
}

#Preview {
    IntesaLoginWelcomeView().environmentObject(AppState())
}