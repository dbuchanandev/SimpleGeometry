//
//  GeometryModifierBackground.swift
//  
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct GeometryModifierBackground: ViewModifier {
    
    @Binding
    var frameRect: CGRect
    let coordinateSpace: CoordinateSpace
    
    init(
        _ frameRect: Binding<CGRect>,
        _ coordinateSpace: CoordinateSpace
    )
    {
        _frameRect = frameRect
        self.coordinateSpace = coordinateSpace
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: FrameRectPreferenceKey.self, 
                            value: geometry.frame(in: coordinateSpace)
                        )
                        //This placement matters a lot
                        .onPreferenceChange(FrameRectPreferenceKey.self) { value in
                            dispatch(frameRect = value)
                        }
                        .allowsHitTesting(false)
                }
            )
    }
    
    func dispatch(_ action: ()) {
        DispatchQueue(label: "PreferenceKeysQueue").async {
            action
        }
    }
}
