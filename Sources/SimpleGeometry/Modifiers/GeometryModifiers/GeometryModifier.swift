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
    let frameBehavior: FrameBehavior
    
    @Binding
    var frameRect: CGRect
    let coordinateSpace: CoordinateSpace
    
    //MARK: - Rect Init
    init(
        _ frameRect: Binding<CGRect>,
        _ coordinateSpace: CoordinateSpace = .global,
        _ frameBehavior: FrameBehavior = .default
    )
    {
        _frameRect = frameRect
        self.frameBehavior = frameBehavior
        self.coordinateSpace = coordinateSpace
    }
    
    func body(content: Content) -> some View {
        
        content
            .modifier(GeometryModifierBackground($frameRect, coordinateSpace, frameBehavior))
            
    }
    
    func dispatch(_ action: ()) {
        DispatchQueue(label: "PreferenceKeysQueue").async {
            action
        }
    }
}
