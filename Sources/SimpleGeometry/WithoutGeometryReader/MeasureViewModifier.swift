//
//  MeasureViewModifier.swift
//
//
//  Created by Donavon Buchanan on 10/13/20.
//

import SwiftUI

struct MeasureViewModifier: ViewModifier {
    @Binding
    var rect: CGRect

    func body(content: Content) -> some View {
        content
            .background(
                MeasuringView(rect: $rect)
            )
    }
}
