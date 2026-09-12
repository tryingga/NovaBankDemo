import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var logoAppeared = false

    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: Theme.Spacing.xl) {
                    Spacer(minLength: 60)

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

                        Text("Nova Bank")
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

                    VStack(spacing: Theme.Spacing.m) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Username")
                                .font(Theme.Fonts.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                            TextField("demo", text: $username)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding()
                                .background(Theme.Colors.surface)
                                .cornerRadius(Theme.Radius.button)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Password")
                                .font(Theme.Fonts.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                            SecureField("demo123", text: $password)
                                .padding()
                                .background(Theme.Colors.surface)
                                .cornerRadius(Theme.Radius.button)
                        }

                        if let error = appState.loginError {
                            Text(error)
                                .font(Theme.Fonts.caption)
                                .foregroundColor(Theme.Colors.negative)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, Theme.Spacing.l)

                    VStack(spacing: Theme.Spacing.m) {
                        PrimaryButton(title: "Accedi") {
                            appState.attemptLogin(username: username, password: password)
                        }

                        SecondaryButton(title: "Accedi alla demo", icon: "bolt.fill") {
                            appState.loginAsDemo()
                        }
                    }
                    .padding(.horizontal, Theme.Spacing.l)

                    Text("Credenziali demo precompilate: demo / demo123")
                        .font(Theme.Fonts.caption)
                        .foregroundColor(Theme.Colors.textSecondary)

                    Spacer(minLength: 40)
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                logoAppeared = true
            }
        }
    }
}

#Preview {
    LoginView().environmentObject(AppState())
}
