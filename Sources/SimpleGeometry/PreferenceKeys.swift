//
//  PreferenceKeys.swift
//  
//
//  Created by Donavon Buchanan on 10/2/20.
//

import SwiftUI

// MARK: - Size
@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct FrameRectPreferenceKey: PreferenceKey {
    static let defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect,
                       nextValue: () -> CGRect) {
        value = nextValue()
    }
}
