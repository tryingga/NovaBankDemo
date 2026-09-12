import SwiftUI

struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(Theme.Fonts.title)
                .foregroundColor(Theme.Colors.textPrimary)
            Spacer()
            if let actionTitle, let action {
                Button(action: action) {
                    Text(actionTitle)
                        .font(Theme.Fonts.body)
                        .foregroundColor(Theme.Colors.primary)
                }
            }
        }
    }
}
