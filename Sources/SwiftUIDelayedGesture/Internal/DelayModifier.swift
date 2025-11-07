/**
*  SwiftUIDelayedGesture
*  Copyright (c) Ciaran O'Brien 2025
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct DelayModifier: ViewModifier {
    @StateObject private var state = DelayState()
    
    var action: () -> Void
    var delay: TimeInterval
    
    func body(content: Content) -> some View {
        Button(action: action) {
            content
        }
        .buttonStyle(DelayButtonStyle(delay: delay))
        .accessibilityRemoveTraits(.isButton)
        .environmentObject(state)
        .disabled(state.disabled)
    }
}


private struct DelayButtonStyle: ButtonStyle {
    @EnvironmentObject private var state: DelayState
    
    var delay: TimeInterval
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { isPressed in
                state.onIsPressed(isPressed, delay: delay)
            }
    }
}


@MainActor
private final class DelayState: ObservableObject {
    @Published private(set) var disabled = false
    
    func onIsPressed(_ isPressed: Bool, delay: TimeInterval) {
        workItem.cancel()
        
        if isPressed {
            workItem = DispatchWorkItem { [weak self] in
                guard let self else { return }
                
                self.objectWillChange.send()
                self.disabled = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + max(delay, 0), execute: workItem)
        } else {
            disabled = false
        }
    }
    
    private var workItem = DispatchWorkItem(block: {})
}
