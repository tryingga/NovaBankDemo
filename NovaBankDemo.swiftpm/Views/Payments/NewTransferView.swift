import SwiftUI

struct NewTransferView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var recipient = ""
    @State private var iban = ""
    @State private var amountText = ""
    @State private var reason = ""
    @State private var showSuccess = false

    private var amount: Double {
        Double(amountText.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    private var isValid: Bool {
        !recipient.isEmpty && !iban.isEmpty && amount > 0 && amount <= appState.account.balance
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.Spacing.l) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Saldo disponibile")
                            .font(Theme.Fonts.caption)
                            .foregroundColor(Theme.Colors.textSecondary)
                        Text(appState.account.balance.asCurrency())
                            .font(Theme.Fonts.headline)
                            .foregroundColor(Theme.Colors.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(Theme.Spacing.l)
                    .background(Theme.Colors.surfaceSoft)
                    .cornerRadius(Theme.Radius.card)

                    FormField(label: "Beneficiario", placeholder: "Nome e cognome", text: $recipient)
                    FormField(label: "IBAN", placeholder: "IT00 X000 0000 0000 0000 0000 000", text: $iban)
                    FormField(label: "Importo (€)", placeholder: "0,00", text: $amountText, keyboard: .decimalPad)
                    FormField(label: "Causale (opzionale)", placeholder: "Es. Rimborso cena", text: $reason)

                    if amount > appState.account.balance {
                        Text("Saldo insufficiente per completare l'operazione.")
                            .font(Theme.Fonts.caption)
                            .foregroundColor(Theme.Colors.negative)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    PrimaryButton(title: "Conferma bonifico", isDisabled: !isValid) {
                        appState.performSimulatedTransfer(recipient: recipient, amount: amount, reason: reason)
                        showSuccess = true
                    }
                }
                .padding(Theme.Spacing.l)
            }
            .background(Color.white.ignoresSafeArea())
            .pageHeader(title: "Nuovo bonifico", inline: true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") { dismiss() }
                }
            }
            .fullScreenCover(isPresented: $showSuccess) {
                OperationSuccessView(
                    title: "Bonifico inviato",
                    subtitle: "Hai inviato \(amount.asCurrency()) a \(recipient).",
                    onDone: { dismiss() }
                )
            }
        }
    }
}

struct FormField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(Theme.Fonts.caption)
                .foregroundColor(Theme.Colors.textSecondary)
            TextField(placeholder, text: $text)
                .keyboardType(keyboard)
                .padding()
                .background(Theme.Colors.surfaceSoft)
                .cornerRadius(Theme.Radius.button)
        }
    }
}

#Preview {
    NewTransferView().environmentObject(AppState())
}
