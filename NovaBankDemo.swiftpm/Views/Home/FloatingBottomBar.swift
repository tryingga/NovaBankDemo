import SwiftUI

/// Pulsante flottante "Chat" in basso a destra.
struct FloatingChatButton: View {
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 14) {
                Image(systemName: "message")
                    .font(.system(size: 34, weight: .regular))
                Text("Chat")
                    .font(.system(size: 25, weight: .regular))
            }
            .foregroundColor(.white)
            .frame(width: 208, height: 105)
            .background(Color.black)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 6)
        }
        .buttonStyle(.plain)
    }
}

/// Bottom navigation a pillola con 5 tab. Home e' lo stato attivo.
struct FloatingBottomNavBar: View {
    @Binding var selection: NovaTab

    var body: some View {
        HStack(spacing: 0) {
            navItem(.home, "house.fill", "Home", badge: nil)
            navItem(.investimenti, "chart.bar", "Investimenti", badge: nil)
            navItem(.operazioni, "eurosign.circle", "Operazioni", badge: nil)
            navItem(.carte, "creditcard", "Carte", badge: nil)
            navItem(.altro, "list.bullet", "Altro", badge: "250")
        }
        .padding(.horizontal, 10)
        .frame(width: 652, height: 105)
        .background(Color.white)
        .clipShape(Capsule())
        .overlay(
            Capsule().stroke(Color.black, lineWidth: 2)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
    }

    private func navItem(_ tab: NovaTab, _ icon: String, _ label: String, badge: String?) -> some View {
        let isSelected = selection == tab
        return Button {
            withAnimation(.easeInOut(duration: 0.18)) {
                selection = tab
            }
        } label: {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: icon)
                        .font(.system(size: 32, weight: isSelected ? .semibold : .regular))
                        .foregroundColor(isSelected ? Theme.Colors.homeGradientStart : .black)
                    if let badge {
                        Text(badge)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .frame(height: 34)
                            .background(Capsule().fill(Theme.Colors.novaRed))
                            .offset(x: 13, y: -16)
                    }
                }
                Text(label)
                    .font(.system(size: isSelected ? 22 : 21, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? Theme.Colors.homeGradientStart : Theme.Colors.novaGray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        FloatingBottomNavBar(selection: .constant(.home))
    }
}