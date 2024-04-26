/**
*  SwiftUIDelayedGesture
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public extension View {
    /// Sequences a gesture with a long press and attaches the result to the view,
    /// which results in the gesture only receiving events after the long press
    /// succeeds.
    ///
    /// Use this view modifier *instead* of `.gesture` to delay a gesture:
    ///
    ///     ScrollView {
    ///         FooView()
    ///             .delayedGesture(someGesture, delay: 0.2)
    ///     }
    ///
    /// - Parameters:
    ///    - gesture: A gesture to attach to the view.
    ///    - mask: A value that controls how adding this gesture to the view
    ///      affects other gestures recognized by the view and its subviews.
    ///    - delay: A value that controls the duration of the long press that
    ///      must elapse before the gesture can be recognized by the view.
    ///    - action: An action to perform if a tap gesture is recognized
    ///      before the long press can be recognized by the view.
    func delayedGesture<T: Gesture>(
        _ gesture: T,
        including mask: GestureMask = .all,
        delay: TimeInterval = 0.25,
        onTapGesture action: @escaping () -> Void = {}
    ) -> some View {
        self.modifier(DelayModifier(action: action, delay: delay))
            .gesture(gesture, including: mask)
    }
    
    /// Attaches a long press gesture to the view, which results in gestures with a
    /// lower precedence only receiving events after the long press succeeds.
    ///
    /// Use this view modifier *before* `.gesture` to delay a gesture:
    ///
    ///     ScrollView {
    ///         FooView()
    ///             .delayedInput(delay: 0.2)
    ///             .gesture(someGesture)
    ///     }
    ///
    /// - Parameters:
    ///    - delay: A value that controls the duration of the long press that
    ///      must elapse before lower precedence gestures can be recognized by
    ///      the view.
    ///    - action: An action to perform if a tap gesture is recognized
    ///      before the long press can be recognized by the view.
    func delayedInput(
        delay: TimeInterval = 0.25,
        onTapGesture action: @escaping () -> Void = {}
    ) -> some View {
        modifier(DelayModifier(action: action, delay: delay))
    }
}
