//
//  SGModifier.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

public enum FrameBehavior {
    case `default`, fill
}

struct SGModifier: ViewModifier {
    // MARK: Lifecycle

    init(
        to rect: Binding<CGRect>,
        _ behavior: FrameBehavior = .default,
        _ coordinateSpace: CoordinateSpace = .global
    ) {
        _rect = rect
        self.behavior = behavior
        self.coordinateSpace = coordinateSpace
    }
    
    init(
        to sgObject: Binding<SGObject>
    ) {
        _rect = sgObject.rect
        behavior = sgObject.behavior.wrappedValue
        coordinateSpace = sgObject.coordinateSpace.wrappedValue
    }
    
    // MARK: Internal
    @Binding
    var rect: CGRect
    
    var behavior: FrameBehavior
    var coordinateSpace: CoordinateSpace

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: FrameRectPreferenceKey.self,
                            value: geometry.frame(in: coordinateSpace)
                        )
                        .onPreferenceChange(FrameRectPreferenceKey.self) { value in
                            dispatch(rect = value)
                        }
                        .allowsHitTesting(false)
                }
            )
            .modifier(
                FilledFrameModifier(
                    behavior: behavior,
                    rect: rect
                )
            )
    }
    
    func dispatch(_ action: ()) {
        DispatchQueue(label: "PreferenceKeysQueue").async {
            action
        }
    }
}
