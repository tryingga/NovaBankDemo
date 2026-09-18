import SwiftUI

/// Fila orizzontalmente scrollabile dei pulsanti rapidi neri.
/// Il terzo pulsante viene tagliato dal bordo destro, come nello screenshot.
struct QuickActionsStrip: View {
    @State private var showTransfer = false
    var onShowCards: (() -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                QuickActionButton(
                    "Bonifico",
                    width: 182,
                    icon: MoneyCoinIcon()
                ) {
                    showTransfer = true
                }
                QuickActionButton(
                    "Carta virtuale",
                    width: 246,
                    icon: VirtualCardIcon()
                ) {
                    onShowCards?()
                }
                QuickActionButton(
                    "CBILL/pagoPA",
                    width: 330,
                    icon: CbillDocumentIcon()
                ) {}
            }
            .padding(.leading, 27)
            .padding(.vertical, 0)
        }
        .place(0, 688, 706, 70)
        .sheet(isPresented: $showTransfer) {
            NewTransferView()
        }
    }
}

/// Bottone nero con icona bianca a sinistra dell'etichetta.
struct QuickActionButton<Icon: View>: View {
    let title: String
    let width: CGFloat
    let icon: Icon
    let action: () -> Void

    init(_ title: String, width: CGFloat, icon: Icon, action: @escaping () -> Void = {}) {
        self.title = title
        self.width = width
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                icon
                Text(title)
                    .font(.system(size: 28, weight: .light))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            }
            .frame(width: width, height: 70)
            .background(Color.black)
            .cornerRadius(17)
        }
        .buttonStyle(.plain)
    }
}

/// Icona moneta con simbolo euro (Bonifico).
private struct MoneyCoinIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 2.5)
                .frame(width: 30, height: 30)
            Text("€")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(.white)
        }
        .frame(width: 30, height: 30)
    }
}

/// Icona carta di credito con chip (Carta virtuale).
private struct VirtualCardIcon: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.white, lineWidth: 2.2)
                .frame(width: 38, height: 24)
            RoundedRectangle(cornerRadius: 1.5)
                .stroke(Color.white, lineWidth: 1.6)
                .frame(width: 12, height: 9)
                .offset(x: -8, y: 0)
        }
        .frame(width: 40, height: 36)
    }
}

/// Arco semicircolare usato per le onde di prossimita'.
private struct NfcArc: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: rect.width / 2,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: true
        )
        return path
    }
}

/// Icona documento con euro (CBILL/pagoPA).
private struct CbillDocumentIcon: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.white, lineWidth: 2.4)
                .frame(width: 30, height: 38)
            Text("€")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(.white)
        }
        .frame(width: 34, height: 40)
    }
}

#Preview {
    ZStack {
        Theme.Colors.novaGreen.ignoresSafeArea()
        QuickActionsStrip()
    }
}