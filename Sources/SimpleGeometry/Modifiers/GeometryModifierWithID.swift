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
    @StateObject
    var identifiableRect: IdentifiableRect
    
    //MARK: - Rect Init
    init(
        _ identifiableRect: IdentifiableRect
    )
    {
        _identifiableRect = StateObject(wrappedValue: identifiableRect)
    }
    
    func body(content: Content) -> some View {
        
        content
            .modifier(GeometryModifierBackground($identifiableRect.frameRect, identifiableRect.coordinateSpace))
            .modifier(
                FilledFrameModifier(
                    frameBehavior: identifiableRect.frameBehavior,
                    frameRect: identifiableRect.frameRect
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
