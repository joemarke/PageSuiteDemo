//
//  PrimaryButtonViewModifier.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 25/07/2024.
//

import SwiftUI

struct PrimaryButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.blue)
            .clipShape(.capsule)
    }
}

#Preview {
    Button {
        print("Selected")
    } label: {
        Text("Press Me")
            .primaryButton()
    }
}
