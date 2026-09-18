import SwiftUI

/// Coordinate del canvas di riferimento (706x1536 px, come lo screenshot originale).
enum HomeDesign {
    static let width: CGFloat = 706
    static let height: CGFloat = 1536

    static let heroHeight: CGFloat = 830
    static let movHeaderHeight: CGFloat = 195
    static let rowHeight: CGFloat = 205
    static let cardsHeaderHeight: CGFloat = 144
    static let cardsSectionHeight: CGFloat = 935
    static let featuredSectionHeight: CGFloat = 606
    static let bottomEndPadding: CGFloat = 240

    static let movementRowCount = 3

    static var totalHeight: CGFloat {
        heroHeight
            + movHeaderHeight
            + CGFloat(movementRowCount) * rowHeight
            + cardsSectionHeight
            + featuredSectionHeight
            + bottomEndPadding
    }
}

extension View {
    /// Posiziona una view in coordinate assolute del canvas (top-leading).
    func place(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> some View {
        self
            .frame(width: w, height: h, alignment: .topLeading)
            .offset(x: x, y: y)
    }
}

/// Disegna un contenuto nel canvas di design e lo scala proporzionalmente alla larghezza disponibile
/// (ancorato in alto a sinistra). Usato per il contenuto scrollabile della Home.
struct ScaledCanvas<Content: View>: View {
    let contentWidth: CGFloat
    let contentHeight: CGFloat
    @ViewBuilder var content: Content

    var body: some View {
        GeometryReader { geo in
            let scale = geo.size.width / contentWidth
            content
                .frame(width: contentWidth, height: contentHeight)
                .scaleEffect(scale, anchor: .topLeading)
                .frame(width: geo.size.width, height: contentHeight * scale, alignment: .topLeading)
        }
    }
}

/// Contenuto flottante ancorato al fondo dello schermo (bottom navigation e pulsante Chat),
/// scalato con le stesse proporzioni del canvas e sollevato sopra la safe area.
struct BottomOverlay<Content: View>: View {
    let contentWidth: CGFloat
    let contentHeight: CGFloat
    @ViewBuilder var content: Content

    var body: some View {
        GeometryReader { geo in
            let scale = min(
                geo.size.width / contentWidth,
                geo.size.height / contentHeight
            )
            let bottomInset = geo.safeAreaInsets.bottom
            content
                .frame(width: contentWidth, height: contentHeight)
                .scaleEffect(scale, anchor: .bottom)
                .frame(width: contentWidth * scale, height: contentHeight * scale, alignment: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .offset(y: -bottomInset)
        }
    }
}