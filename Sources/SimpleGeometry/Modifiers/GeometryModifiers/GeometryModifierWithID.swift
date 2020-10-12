//
//  GeometryModifierWithID.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

#if !os(macOS)
    @available(iOS 14.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
    struct GeometryModifierWithID: ViewModifier {
        // MARK: Lifecycle

        init(
            _ sGObject: SGObject
        ) {
            _sGObject = StateObject(wrappedValue: sGObject)
        }

        // MARK: Internal

        @StateObject
        var sGObject: SGObject

        func body(content: Content) -> some View {
            content
                .modifier(
                    GeometryModifierBackground(
                        sGObject
                    )
                )
        }
    }
#endif
