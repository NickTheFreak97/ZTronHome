import SwiftUI


extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .leading,
                endPoint: .trailing)
        )
        .mask(self)
    }
}
