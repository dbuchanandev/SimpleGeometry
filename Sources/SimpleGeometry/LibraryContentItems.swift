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
            
            items.append(
                LibraryItem(
                    base.readSize(to: sgObject),
                    visible: true,
                    title: "Read Frame",
                    category: .layout
                )
            )
            
            items.append(
                LibraryItem(
                    base.readParentSize(to: sgObject),
                    visible: true,
                    title: "Read Parent Frame",
                    category: .layout
                )
            )
            
            return items
        }

        // MARK: Internal
        @Binding
        var sgObject: SGObject
    }
#endif
