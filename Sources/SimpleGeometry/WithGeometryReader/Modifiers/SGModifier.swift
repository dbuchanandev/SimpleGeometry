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
                        .preference(
                            key: SizePreferenceKey.self,
                            value: geometry.size
                        )
                        .onPreferenceChange(FrameRectPreferenceKey.self) { value in
                            dispatch(
                                sgObject.rect = value
                            )
                        }
                        .onPreferenceChange(SizePreferenceKey.self) { value in
                            dispatch(
                                sgObject.size = value
                            )
                        }
                        .allowsHitTesting(false)
                }
            )
            .modifier(
                FilledFrameModifier(
                    behavior: sgObject.behavior,
                    alignment: sgObject.alignment
                )
            )
    }

    func dispatch(_ action: ()) {
        DispatchQueue(label: "PreferenceKeysQueue").async {
            action
        }
    }
}
