import SwiftUI

struct TopUpView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var phoneNumber = ""
    @State private var amountText = "10"
    @State private var showSuccess = false

    private let quickAmounts: [Double] = [5, 10, 20, 50]

    private var amount: Double {
        Double(amountText.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    private var isValid: Bool {
        phoneNumber.count >= 6 && amount > 0 && amount <= appState.account.balance
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.Spacing.l) {
                    FormField(label: "Numero di telefono", placeholder: "333 123 4567", text: $phoneNumber, keyboard: .phonePad)

                    VStack(alignment: .leading, spacing: Theme.Spacing.s) {
                        Text("Importo")
                            .font(Theme.Fonts.caption)
                            .foregroundColor(Theme.Colors.textSecondary)
                        HStack(spacing: Theme.Spacing.s) {
                            ForEach(quickAmounts, id: \.self) { value in
                                Button {
                                    amountText = String(format: "%.0f", value)
                                } label: {
                                    Text("€\(Int(value))")
                                        .font(Theme.Fonts.body)
                                        .padding(.horizontal, Theme.Spacing.m)
                                        .padding(.vertical, Theme.Spacing.s)
                                        .background(
                                            amount == value ? Theme.Colors.primary : Theme.Colors.surface
                                        )
                                        .foregroundColor(amount == value ? .white : Theme.Colors.textPrimary)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        TextField("Importo personalizzato", text: $amountText)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Theme.Colors.surface)
                            .cornerRadius(Theme.Radius.button)
                    }

                    PrimaryButton(title: "Conferma ricarica", isDisabled: !isValid) {
                        appState.performSimulatedTopUp(number: phoneNumber, amount: amount)
                        showSuccess = true
                    }
                }
                .padding(Theme.Spacing.l)
            }
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("Ricarica telefonica")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") { dismiss() }
                }
            }
            .fullScreenCover(isPresented: $showSuccess) {
                OperationSuccessView(
                    title: "Ricarica effettuata",
                    subtitle: "Hai ricaricato \(amount.asCurrency()) sul numero \(phoneNumber).",
                    onDone: { dismiss() }
                )
            }
        }
    }
}

#Preview {
    TopUpView().environmentObject(AppState())
}
