//
//  FilledFrameModifier.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

struct FilledFrameModifier: ViewModifier {
    let behavior: FrameBehavior
    let alignment: Alignment?

    @ViewBuilder
    func body(content: Content) -> some View {
        switch behavior {
        case .fill:
            content
                .frame(
                    maxWidth: behavior == .fill ? .infinity : .none,
                    maxHeight: behavior == .fill ? .infinity : .none,
                    alignment: alignment ?? .center
                )
        default:
            content
        }
    }
}
