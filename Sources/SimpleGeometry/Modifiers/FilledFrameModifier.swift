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
                    minWidth: .none,
                    idealWidth: .none,
                    maxWidth: behavior == .fill ? .infinity : .none,
                    minHeight: .none,
                    idealHeight: .none,
                    maxHeight: behavior == .fill ? .infinity : .none,
                    alignment: alignment ?? .center
                )
        default:
            content
        }
    }
}
