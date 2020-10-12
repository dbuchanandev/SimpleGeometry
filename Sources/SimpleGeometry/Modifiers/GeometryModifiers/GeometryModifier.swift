//
//  GeometryModifier.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

public enum FrameBehavior {
    case `default`, fill
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct GeometryModifier: ViewModifier {
    // MARK: Lifecycle

    init(
        to: Binding<CGRect>,
        _ behavior: FrameBehavior = .default,
        _ coordinateSpace: CoordinateSpace = .global
    ) {
        self.sgObject = SGObject(to: to, behavior: behavior, coordinateSpace: coordinateSpace)
    }

    // MARK: Internal

    var sgObject: SGObject

    func body(content: Content) -> some View {
        content
            .modifier(SGModifier(sgObject))
    }

    func dispatch(_ action: ()) {
        DispatchQueue(label: "PreferenceKeysQueue").async {
            action
        }
    }
}
