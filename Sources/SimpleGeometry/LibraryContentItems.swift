//
//  LibraryContentItems.swift
//
//
//  Created by Donavon Buchanan on 10/2/20.
//

#if canImport(DeveloperToolsSupport)
    import DeveloperToolsSupport
    import SwiftUI

    public struct LibraryModifierContent: LibraryContentProvider {
        // MARK: Public

        //    @LibraryContentBuilder
        public func modifiers(base: AnyView) -> [LibraryItem] {
            var items: [LibraryItem] = []
            #if !os(macOS)
                items.append(
                    LibraryItem(
                        base.readFrame(to: $sgObject),
                        visible: true,
                        title: "Read Frame",
                        category: .layout
                    )
                )
            #endif
            items.append(
                LibraryItem(
                    base.readFrameToRect(
                        to: $rect,
                        behavior: behavior,
                        in: coordinateSpace
                    ),
                    visible: true,
                    title: "Read Frame to CGRect",
                    category: .layout
                )
            )
            return items
        }

        // MARK: Internal
        @Binding
        var sgObject: SGObject

        @Binding
        var size: CGSize

        let behavior: FrameBehavior

        @Binding
        var rect: CGRect

        let coordinateSpace: CoordinateSpace
    }
#endif
