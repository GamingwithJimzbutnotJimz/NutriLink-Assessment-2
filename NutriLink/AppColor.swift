import SwiftUI

// MARK: - Colors
enum AppColor {
    static let brand          = Color(red: 0.11, green: 0.47, blue: 0.96) // primary blue
    static let brandAlt       = Color(red: 0.06, green: 0.79, blue: 0.53) // mint
    static let textPrimary    = Color.primary
    static let textSecondary  = Color.secondary
    static let cardBackground = Color(.secondarySystemBackground)         // dynamic
    static let separator      = Color(.tertiarySystemFill)
}

// MARK: - Fonts
enum AppFont {
    static func titleLarge(_ weight: Font.Weight = .bold) -> Font {
        .system(.largeTitle, design: .rounded).weight(weight)
    }
    static func title(_ weight: Font.Weight = .semibold) -> Font {
        .system(.title2, design: .rounded).weight(weight)
    }
    static func body() -> Font {
        .system(.body, design: .rounded)
    }
    static func caption() -> Font {
        .system(.caption, design: .rounded)
    }
}

// MARK: - Reusable Modifiers
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(14)
            .background(AppColor.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.title(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                LinearGradient(
                    colors: [AppColor.brand, AppColor.brandAlt],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .opacity(configuration.isPressed ? 0.85 : 1)
            )
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: AppColor.brand.opacity(0.18), radius: 12, y: 6)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Helpers
extension View {
    /// Apply card-like padding + background styling
    func asCard() -> some View { modifier(CardStyle()) }
}
