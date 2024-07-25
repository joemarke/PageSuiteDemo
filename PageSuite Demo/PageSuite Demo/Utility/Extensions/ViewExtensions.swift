//
//  ViewExtensions.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 25/07/2024.
//

import SwiftUI

extension View {
    func primaryButton() -> some View {
        modifier(PrimaryButtonViewModifier())
    }
}
