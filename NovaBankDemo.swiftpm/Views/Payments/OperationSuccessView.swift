import SwiftUI

struct OperationSuccessView: View {
    let title: String
    let subtitle: String
    var onDone: (() -> Void)? = nil

    @Environment(\.dismiss) private var dismiss
    @State private var checkmarkScale: CGFloat = 0.5
    @State private var checkmarkOpacity: Double = 0

    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Theme.Colors.incomeGreenSoft)
                    .frame(width: 100, height: 100)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(Theme.Colors.brandGreen)
            }
            .scaleEffect(checkmarkScale)
            .opacity(checkmarkOpacity)

            VStack(spacing: Theme.Spacing.s) {
                Text(title)
                    .font(Theme.Fonts.title)
                    .foregroundColor(Theme.Colors.textPrimary)
                Text(subtitle)
                    .font(Theme.Fonts.body)
                    .foregroundColor(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Theme.Spacing.xl)
            }

            Text("Operazione simulata — nessun movimento reale è stato effettuato")
                .font(Theme.Fonts.caption)
                .foregroundColor(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.Spacing.xl)

            Spacer()

            PrimaryButton(title: "Fatto") {
                if let onDone {
                    onDone()
                } else {
                    dismiss()
                }
            }
            .padding(.horizontal, Theme.Spacing.l)
        }
        .padding(.vertical, Theme.Spacing.xl)
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.6)) {
                checkmarkScale = 1.0
                checkmarkOpacity = 1.0
            }
        }
    }
}

#Preview {
    OperationSuccessView(title: "Bonifico inviato", subtitle: "Hai inviato € 50,00 a Anna Verdi.")
}
