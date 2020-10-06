//
//  FilledFrameModifier.swift
//  
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct FilledFrameModifier: ViewModifier {
    
    let frameBehavior: FrameBehavior
    let frameRect: CGRect
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch frameBehavior {
        case .fill:
            content
                .frame(
                    minWidth: frameRect.width, 
                    idealWidth: frameRect.width, 
                    maxWidth: frameBehavior == .fill ? .infinity : frameRect.width, 
                    minHeight: frameRect.height, 
                    idealHeight: frameRect.height, 
                    maxHeight: frameBehavior == .fill ? .infinity : frameRect.height
                )
        default:
            content
        }
    }
}
