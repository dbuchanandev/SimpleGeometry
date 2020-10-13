//
//  PreferenceKeys.swift
//
//
//  Created by Donavon Buchanan on 10/2/20.
//

import SwiftUI

struct FrameRectPreferenceKey: PreferenceKey {
    static let defaultValue: CGRect = .zero

    static func reduce(
        value: inout CGRect,
        nextValue: () -> CGRect
    ) {
        value = nextValue()
    }
}
