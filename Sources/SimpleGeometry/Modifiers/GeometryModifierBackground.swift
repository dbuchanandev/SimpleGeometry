//
//  GeometryModifierBackground.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct GeometryModifierBackground: ViewModifier {
    // MARK: Lifecycle

    init(
        _ sGObject: SGObject
    ) {
        self.sGObject = sGObject
    }

    // MARK: Internal

    var sGObject: SGObject

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: FrameRectPreferenceKey.self,
                            value: geometry.frame(in: sGObject.coordinateSpace)
                        )
                        .onPreferenceChange(FrameRectPreferenceKey.self) { value in
                            dispatch(sGObject.rect = value)
                        }
                        .allowsHitTesting(false)
                }
            )
            .modifier(
                FilledFrameModifier(
                    behavior: sGObject.behavior,
                    rect: sGObject.rect
                )
            )
    }

    func dispatch(_ action: ()) {
        DispatchQueue(label: "PreferenceKeysQueue").async {
            action
        }
    }
}
