//
//  MeasureContainingViewModifier.swift
//
//
//  Created by Donavon Buchanan on 10/13/20.
//

import SwiftUI

struct MeasureContainingViewModifier: ViewModifier {
    @Binding
    var size: CGSize

    func body(content: Content) -> some View {
        ZStack {
            MeasuringView(size: $size)

            content
        }
    }
}
