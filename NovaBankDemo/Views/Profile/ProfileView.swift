import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var notificationsEnabled = true
    @State private var faceIDEnabled = false
    @State private var showLogoutConfirm = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.Spacing.l) {
                    VStack(spacing: Theme.Spacing.s) {
                        ZStack {
                            Circle()
                                .fill(Theme.Colors.primary)
                                .frame(width: 72, height: 72)
                            Text(initials(from: appState.profile.fullName))
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        Text(appState.profile.fullName)
                            .font(Theme.Fonts.title)
                            .foregroundColor(Theme.Colors.textPrimary)
                        Text(appState.profile.email)
                            .font(Theme.Fonts.body)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                    .padding(.top, Theme.Spacing.l)

                    SettingsSection(title: "Preferenze") {
                        SettingsToggleRow(icon: "bell.fill", title: "Notifiche", isOn: $notificationsEnabled)
                        Divider().padding(.leading, 52)
                        SettingsToggleRow(icon: "faceid", title: "Face ID (simulato)", isOn: $faceIDEnabled)
                    }

                    SettingsSection(title: "Sicurezza") {
                        SettingsNavRow(icon: "lock.fill", title: "Sicurezza account (demo)")
                        Divider().padding(.leading, 52)
                        SettingsNavRow(icon: "key.fill", title: "Cambia PIN (simulato)")
                    }

                    SettingsSection(title: "Informazioni") {
                        SettingsNavRow(icon: "info.circle.fill", title: "Informazioni sull'app")
                        Divider().padding(.leading, 52)
                        HStack {
                            Text("Versione")
                                .font(Theme.Fonts.body)
                                .foregroundColor(Theme.Colors.textPrimary)
                            Spacer()
                            Text("1.0.0 (Demo)")
                                .font(Theme.Fonts.body)
                                .foregroundColor(Theme.Colors.textSecondary)
                        }
                        .padding(Theme.Spacing.l)
                    }

                    Text("PROTOTIPO — USO DIMOSTRATIVO\nProgetto scolastico, nessun dato reale.")
                        .font(Theme.Fonts.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .multilineTextAlignment(.center)

                    Button(role: .destructive) {
                        showLogoutConfirm = true
                    } label: {
                        Text("Esci")
                            .font(Theme.Fonts.headline)
                            .foregroundColor(Theme.Colors.negative)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Theme.Colors.negative.opacity(0.08))
                            .cornerRadius(Theme.Radius.button)
                    }
                }
                .padding(Theme.Spacing.l)
            }
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("Profilo")
            .confirmationDialog("Vuoi uscire dalla demo?", isPresented: $showLogoutConfirm, titleVisibility: .visible) {
                Button("Esci", role: .destructive) { appState.logout() }
                Button("Annulla", role: .cancel) {}
            }
        }
    }

    private func initials(from name: String) -> String {
        let parts = name.split(separator: " ")
        let letters = parts.compactMap { $0.first }.prefix(2)
        return letters.map(String.init).joined().uppercased()
    }
}

private struct SettingsSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s) {
            Text(title)
                .font(Theme.Fonts.caption)
                .foregroundColor(Theme.Colors.textSecondary)
                .padding(.leading, Theme.Spacing.s)
            VStack(spacing: 0) {
                content
            }
            .background(Theme.Colors.surface)
            .cornerRadius(Theme.Radius.card)
            .cardShadowStyle()
        }
    }
}

private struct SettingsToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: Theme.Spacing.m) {
            Image(systemName: icon)
                .foregroundColor(Theme.Colors.primary)
                .frame(width: 28)
            Text(title)
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.Colors.textPrimary)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Theme.Colors.accent)
        }
        .padding(Theme.Spacing.l)
    }
}

private struct SettingsNavRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: Theme.Spacing.m) {
            Image(systemName: icon)
                .foregroundColor(Theme.Colors.primary)
                .frame(width: 28)
            Text(title)
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.Colors.textPrimary)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(Theme.Colors.textSecondary)
        }
        .padding(Theme.Spacing.l)
    }
}

#Preview {
    ProfileView().environmentObject(AppState())
}
