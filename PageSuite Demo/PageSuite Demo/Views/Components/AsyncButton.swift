//
//  AsyncButton.swift
//  PageSuite Demo
//
//  Created by Joe Marke on 24/07/2024.
//

import SwiftUI

/// Button used for async tasks. Prevents multiple calls of the same task by disabling the button whilst a task is active.
struct AsyncButton<T: View>: View {
    init(action: @escaping () async -> Void, @ViewBuilder label: @escaping () -> T) {
        self.action = action
        self.label = label
    }
    
    let label: () -> T
    var action: () async -> Void
    @State private var isPerformingTask = false
    
    var body: some View {
        Button {
            isPerformingTask = true
            Task {
                await action()
                isPerformingTask = false
            }
        } label: {
            label()
        }
        .disabled(isPerformingTask)
    }
}

#Preview {
    AsyncButton {
        print("Pressed")
    } label: {
        Text("Press me")
    }
}
