import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isDisabled: Bool = false
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            action()
        }) {
            Text(title)
                .font(Theme.Fonts.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(isDisabled ? Theme.Colors.textSecondary.opacity(0.4) : Theme.Colors.primary)
                .cornerRadius(Theme.Radius.button)
                .scaleEffect(isPressed ? 0.97 : 1.0)
        }
        .disabled(isDisabled)
        .buttonStyle(PressableButtonStyle(isPressed: $isPressed))
    }
}

struct PressableButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, newValue in
                withAnimation(.easeOut(duration: 0.15)) {
                    isPressed = newValue
                }
            }
    }
}

struct SecondaryButton: View {
    let title: String
    let icon: String?
    let action: () -> Void

    init(title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.s) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(title)
            }
            .font(Theme.Fonts.headline)
            .foregroundColor(Theme.Colors.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Theme.Colors.primary.opacity(0.08))
            .cornerRadius(Theme.Radius.button)
        }
    }
}
