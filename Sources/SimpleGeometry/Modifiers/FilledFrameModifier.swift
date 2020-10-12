//
//  FilledFrameModifier.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

struct FilledFrameModifier: ViewModifier {
    let behavior: FrameBehavior
    let rect: CGRect
    let alignment: Alignment?

    @ViewBuilder
    func body(content: Content) -> some View {
        switch behavior {
        case .fill:
            content
                .frame(
                    minWidth: 0,
                    idealWidth: 0,
                    maxWidth: behavior == .fill ? .infinity : rect.width,
                    minHeight: 0,
                    idealHeight: 0,
                    maxHeight: behavior == .fill ? .infinity : rect.height,
                    alignment: alignment ?? .center
                )
        default:
            content
        }
    }
}
