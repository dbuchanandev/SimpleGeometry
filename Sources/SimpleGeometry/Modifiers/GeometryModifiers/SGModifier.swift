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
        to sgObject: SGObject
    ) {
        _sgObject = StateObject(wrappedValue: sgObject)
    }
    
    // MARK: Internal
    @StateObject
    private var sgObject: SGObject

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: FrameRectPreferenceKey.self,
                            value: geometry.frame(in: sgObject.coordinateSpace)
                        )
                        .onPreferenceChange(FrameRectPreferenceKey.self) { value in
                            dispatch(sgObject.rect = value)
                        }
                        .allowsHitTesting(false)
                }
            )
            .modifier(
                FilledFrameModifier(
                    behavior: sgObject.behavior,
                    rect: sgObject.rect
                )
            )
    }
    
    func dispatch(_ action: ()) {
        DispatchQueue(label: "PreferenceKeysQueue").async {
            action
        }
    }
}
