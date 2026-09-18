import SwiftUI
import UIKit

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var enteredDigits: [String] = []
    @State private var shakeError: Bool = false
    @State private var logoAppeared = false

    private let codeLength = 4

    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()

            VStack(spacing: Theme.Spacing.xxl) {
                Spacer(minLength: 40)

                VStack(spacing: Theme.Spacing.m) {
                    ZStack {
                        Circle()
                            .fill(Theme.Colors.primary)
                            .frame(width: 72, height: 72)
                        Image(systemName: "n.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
                    .scaleEffect(logoAppeared ? 1 : 0.8)
                    .opacity(logoAppeared ? 1 : 0)

                    Text("Intesa Sanpaolo")
                        .font(Theme.Fonts.largeTitle)
                        .foregroundColor(Theme.Colors.textPrimary)

                    Text("PROTOTIPO — USO DIMOSTRATIVO")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Theme.Colors.negative)
                        .cornerRadius(6)
                }

                // MARK: - Face ID
                VStack(spacing: Theme.Spacing.m) {
                    Button {
                        startFaceID()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Theme.Colors.primary.opacity(0.08))
                                .frame(width: 88, height: 88)
                            if appState.isAuthenticatingFaceID {
                                ProgressView()
                                    .tint(Theme.Colors.primary)
                            } else {
                                Image(systemName: "faceid")
                                    .font(.system(size: 40, weight: .regular))
                                    .foregroundColor(Theme.Colors.primary)
                            }
                        }
                    }
                    .buttonStyle(.plain)

                    Text(appState.isAuthenticatingFaceID ? "Riconoscimento in corso…" : "Tocca per sbloccare con Face ID")
                        .font(Theme.Fonts.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }

                // MARK: - Codice di sblocco (fallback)
                VStack(spacing: Theme.Spacing.l) {
                    Text("Oppure inserisci il codice di sblocco")
                        .font(Theme.Fonts.caption)
                        .foregroundColor(Theme.Colors.textSecondary)

                    HStack(spacing: Theme.Spacing.l) {
                        ForEach(0..<codeLength, id: \.self) { index in
                            Circle()
                                .fill(index < enteredDigits.count ? Theme.Colors.primary : Theme.Colors.divider)
                                .frame(width: 16, height: 16)
                        }
                    }
                    .offset(x: shakeError ? -8 : 0)
                    .animation(
                        shakeError
                            ? .easeInOut(duration: 0.08).repeatCount(4, autoreverses: true)
                            : .default,
                        value: shakeError
                    )

                    if let error = appState.loginError {
                        Text(error)
                            .font(Theme.Fonts.caption)
                            .foregroundColor(Theme.Colors.negative)
                    }

                    numericKeypad
                        .padding(.horizontal, Theme.Spacing.xl)
                }

                Spacer(minLength: 20)
            }
            .padding(.horizontal, Theme.Spacing.l)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                logoAppeared = true
            }
            // Propone automaticamente Face ID all'apertura della schermata, come nelle vere app bancarie.
            startFaceID()
        }
    }

    // MARK: - Tastierino numerico

    private var numericKeypad: some View {
        let rows: [[String]] = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["", "0", "⌫"]
        ]

        return VStack(spacing: Theme.Spacing.l) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: Theme.Spacing.xl) {
                    ForEach(row, id: \.self) { key in
                        keypadButton(for: key)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func keypadButton(for key: String) -> some View {
        if key.isEmpty {
            Color.clear.frame(width: 64, height: 64)
        } else if key == "⌫" {
            Button {
                deleteDigit()
            } label: {
                Image(systemName: "delete.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Theme.Colors.textPrimary)
                    .frame(width: 64, height: 64)
            }
        } else {
            Button {
                appendDigit(key)
            } label: {
                Text(key)
                    .font(.system(size: 26, weight: .medium))
                    .foregroundColor(Theme.Colors.textPrimary)
                    .frame(width: 64, height: 64)
                    .background(Theme.Colors.surface)
                    .clipShape(Circle())
                    .cardShadowStyle()
            }
        }
    }

    // MARK: - Logica codice

    private func appendDigit(_ digit: String) {
        guard enteredDigits.count < codeLength else { return }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        enteredDigits.append(digit)
        appState.loginError = nil

        if enteredDigits.count == codeLength {
            let code = enteredDigits.joined()
            appState.attemptUnlock(code: code)
            if appState.loginError != nil {
                triggerShake()
            }
        }
    }

    private func deleteDigit() {
        guard !enteredDigits.isEmpty else { return }
        enteredDigits.removeLast()
        appState.loginError = nil
    }

    private func triggerShake() {
        shakeError = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            shakeError = false
            enteredDigits.removeAll()
        }
    }

    private func startFaceID() {
        appState.simulateFaceIDAuthentication {}
    }
}

#Preview {
    LoginView().environmentObject(AppState())
}
