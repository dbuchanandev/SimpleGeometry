//
//  PreferenceKeys.swift
//  
//
//  Created by Donavon Buchanan on 10/2/20.
//

import SwiftUI

// MARK: - Size
@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct HeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat,
                       nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct WidthPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat,
                       nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Frame
@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct OriginXPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat,
                       nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct OriginYPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat,
                       nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct FrameHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat,
                       nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct FrameWidthPositionPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat,
                       nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct CoordinateSpacePreferenceKey: PreferenceKey {
    static let defaultValue: CoordinateSpace = .local
    
    static func reduce(value: inout CoordinateSpace,
                       nextValue: () -> CoordinateSpace) {
        value = nextValue()
    }
}

// MARK: - Insets
@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct EdgeInsetsPreferenceKey: PreferenceKey {
    static let defaultValue: EdgeInsets = .init()
    
    static func reduce(value: inout EdgeInsets,
                       nextValue: () -> EdgeInsets) {
        value = nextValue()
    }
}
