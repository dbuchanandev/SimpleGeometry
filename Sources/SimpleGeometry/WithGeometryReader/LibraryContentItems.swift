//
//  LibraryContentItems.swift
//
//
//  Created by Donavon Buchanan on 10/2/20.
//

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

        items.append(
            LibraryItem(
                base.measure(to: $rect),
                visible: true,
                title: "Measure View",
                category: .layout
            )
        )

        items.append(
            LibraryItem(
                base.measureContainingView(to: $rect),
                visible: true,
                title: "Measure Containing View",
                category: .layout
            )
        )

        return items
    }

    // MARK: Internal

    @Binding
    var sgObject: SGObject

    @Binding
    var rect: CGRect
}
