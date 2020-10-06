//
//  IdentifiedRect.swift
//  
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
public class IdentifiableRect: ObservableObject, Identifiable, Equatable {
    
    public static func == (lhs: IdentifiableRect, rhs: IdentifiableRect) -> Bool {
        return lhs.id == rhs.id &&
            lhs.frameRect == rhs.frameRect &&
            lhs.frameBehavior == rhs.frameBehavior &&
            lhs.coordinateSpace == rhs.coordinateSpace
    }
    
    @Published public var id: AnyHashable
    
    @Published public var frameRect: CGRect
    @Published public var frameBehavior: FrameBehavior
    @Published public var coordinateSpace: CoordinateSpace
    
    public init(
        _ frameRect: CGRect = .zero,
        _ coordinateSpace: CoordinateSpace = .global,
        _ frameBehavior: FrameBehavior = .default,
        _ id: AnyHashable = UUID()
    )
    {
        self.frameRect = frameRect
        self.frameBehavior = frameBehavior
        self.coordinateSpace = coordinateSpace
        self.id = id
    }
    
    private var equatableFrameBehavior: Int {
        switch self.frameBehavior {
        case .default:
            return 1
        case .fill:
            return 0
        }
    }
}
