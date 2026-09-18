import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: Theme.Spacing.m) {
            ZStack {
                Circle()
                    .fill(transaction.isIncome ? Theme.Colors.incomeGreenSoft : Theme.Colors.expenseRedSoft)
                    .frame(width: 40, height: 40)
                Image(systemName: transaction.category.iconName)
                    .foregroundColor(transaction.isIncome ? Theme.Colors.brandGreen : Theme.Colors.expenseRed)
                    .font(.system(size: 16, weight: .medium))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.title)
                    .font(Theme.Fonts.headline)
                    .foregroundColor(Theme.Colors.textPrimary)
                Text(transaction.subtitle)
                    .font(Theme.Fonts.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(transaction.formattedAmount)
                    .font(Theme.Fonts.headline)
                    .foregroundColor(transaction.isIncome ? Theme.Colors.brandGreen : Theme.Colors.expenseRed)
                Text(transaction.formattedDate)
                    .font(Theme.Fonts.caption)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
        }
        .padding(.vertical, Theme.Spacing.s)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Theme.Colors.divider)
                .frame(height: 1)
                .offset(y: Theme.Spacing.s)
        }
    }
}
