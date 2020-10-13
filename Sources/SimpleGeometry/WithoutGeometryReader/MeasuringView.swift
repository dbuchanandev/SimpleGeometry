//
//  MeasuringView.swift
//
//
//  Created by Donavon Buchanan on 10/13/20.
//

import SwiftUI

struct MeasuringView: View {
    @Binding
    var rect: CGRect

    var body: some View {
        MeasuringShape(rect: $rect)
            .foregroundColor(.clear)
            .allowsHitTesting(false)
    }
}
