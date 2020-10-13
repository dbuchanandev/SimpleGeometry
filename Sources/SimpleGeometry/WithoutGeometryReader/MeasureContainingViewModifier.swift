//
//  MeasureContainingViewModifier.swift
//
//
//  Created by Donavon Buchanan on 10/13/20.
//

import SwiftUI

struct MeasureContainingViewModifier: ViewModifier {
    @Binding
    var rect: CGRect

    func body(content: Content) -> some View {
        ZStack {
            MeasuringView(rect: $rect)

            content
        }
    }
}
