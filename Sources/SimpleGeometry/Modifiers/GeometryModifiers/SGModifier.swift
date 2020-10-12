//
//  GeometryModifierWithID.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

#if !os(macOS)
    @available(iOS 14.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
    struct SGModifier: ViewModifier {
        // MARK: Lifecycle

        init(
            _ sgObject: SGObject
        ) {
            self.sgObject = sgObject
        }
        
        // MARK: Internal

        var sgObject: SGObject

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
#endif
