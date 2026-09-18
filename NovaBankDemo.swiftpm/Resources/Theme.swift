import SwiftUI

/// Design system centralizzato di Nova Bank (brand fittizio - progetto scolastico).
enum Theme {

    // MARK: - Colori
    enum Colors {
        static let primary = Color(hex: "0B3D91")
        static let accent = Color(hex: "00C2A8")
        static let negative = Color(hex: "E8543E")
        static let background = Color(hex: "F5F7FA")
        static let surface = Color.white
        static let textPrimary = Color(hex: "1A1D29")
        static let textSecondary = Color(hex: "6B7280")
        static let divider = Color(hex: "E5E7EB")

        // Paletta Nova (home)
        static let novaGreen = Color(hex: "458725")
        static let novaGreenLight = Color(hex: "4D8E2F")
        static let novaGreenDark = Color(hex: "3E7A1F")
        static let homeGradientStart = Color(hex: "208303")
        static let homeGradientEnd = Color(hex: "0F6D15")
        static let novaGray = Color(hex: "6F6F6F")
        static let novaGrayLight = Color(hex: "9E9E9E")
        static let novaDivider = Color(hex: "D7D7D7")
        static let novaBlue = Color(hex: "111BC9")
        static let novaRed = Color(hex: "D8322F")
        static let novaLilac = Color(hex: "F0E8F5")
        static let novaBeige = Color(hex: "F8EEE9")

        // Palette Intesa Sanpaolo (login)
        static let intesaGreen = Color(hex: "0A5C2D")
        static let intesaGradientTop = Color(hex: "1F8307")
        static let intesaGradientBottom = Color(hex: "044348")

        // Design system pagine secondarie (riuso stile Home)
        static let brandGreen = Color(hex: "208303")
        static let softBackground = Color(hex: "F9FAFB")
        static let surfaceSoft = Color(hex: "F5F6F8")
        static let expenseRed = Color(hex: "EF4444")
        static let expenseRedSoft = Color(hex: "FEE2E2")
        static let incomeGreenSoft = Color(hex: "DCFCE7")
    }

    // MARK: - Font
    enum Fonts {
        static let largeTitle = Font.system(size: 28, weight: .bold, design: .rounded)
        static let title = Font.system(size: 20, weight: .bold)
        static let headline = Font.system(size: 16, weight: .semibold)
        static let body = Font.system(size: 15, weight: .regular)
        static let caption = Font.system(size: 12, weight: .regular)
        static let amount = Font.system(size: 34, weight: .bold, design: .rounded)
    }

    // MARK: - Spacing
    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 12
        static let l: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    // MARK: - Radius
    enum Radius {
        static let card: CGFloat = 16
        static let button: CGFloat = 12
        static let sheet: CGFloat = 20
    }

    // MARK: - Shadow
    static func cardShadow() -> some View {
        Color.clear
    }
}

extension View {
    func cardShadowStyle() -> some View {
        self.shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
    }

    /// Header di pagina con il gradient orizzontale della Home
    /// (#208303 -> #0F6D15) e testi/icone bianchi nella barra di navigazione.
    func pageHeader(title: String, inline: Bool = false) -> some View {
        self
            .toolbarBackground(
                LinearGradient(
                    colors: [Theme.Colors.homeGradientStart, Theme.Colors.homeGradientEnd],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(inline ? .inline : .large)
            .navigationTitle(title)
    }

    /// Icone di azione bianche in alto a destra (Cerca, Aiuto).
    func pageHeaderActions() -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Image(systemName: "magnifyingglass")
                Image(systemName: "questionmark.circle")
            }
        }
    }
}

extension Color {
    /// Inizializza un Color da una stringa hex tipo "0B3D91".
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
