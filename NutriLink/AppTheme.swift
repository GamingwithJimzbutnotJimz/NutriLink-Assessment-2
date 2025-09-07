//
//  AppTheme.swift
//  NutriLink
//
//  Created by Rifath Parveen on 6/9/2025.
//


import SwiftUI

enum AppTheme {
    static let corner: CGFloat = 12
    static let cardBG = Color(.secondarySystemBackground)
    static let surfaceBG = Color(.systemBackground)
    static let accent = Color.accentColor   // respects app accent / system tint
}

extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(AppTheme.cardBG)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.corner, style: .continuous))
            .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
    }
}
