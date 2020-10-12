//
//  IdentifiedRect.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

@available(*, deprecated, renamed: "SGObject")
@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
public class IdentifiableRect: ObservableObject, Identifiable, Equatable {
    // MARK: Lifecycle

    /// Creates a new IdentifiableRect object.
    /// This class is intended to package together properties needed to read the
    /// geometry of a view, and to hold the `CGRect` where the geometry properties
    /// are stored. Default values are provided for all parameters and will be all that's needed
    /// for typical use cases.
    /// - Parameters:
    ///   - frameRect: `CGRect` value where geometry properties are stored.
    ///   Defaults to a value of `.zero` if no value is supplied. In most cases, this default should be used.
    ///   - coordinateSpace: Indicates the CoordinateSpace of the frame,
    ///   returning X and Y positional values relative to the view with `.local`, the
    ///   screen with `.global`, or a named area with `.named()`.
    ///   Defaults to a value of `.global` if no value is supplied.
    ///   - frameBehavior: A `FrameBehavior` enum case value to indicate
    ///   if the view returned from the modifier should retain the default sizing behavior
    ///   as if unmodified using `.default`, or grow to fill the available space using `.fill`.
    ///   Defaults to a value of `.default` if no value is supplied.
    ///   - id: Any `Hashable` value used to ensure this object will be unique and conform
    ///   to the `Identifiable` protocol. Defaults to a value of `UUID()` if no value is supplied.
    public init(
        _ frameRect: CGRect = .zero,
        _ coordinateSpace: CoordinateSpace = .global,
        _ frameBehavior: FrameBehavior = .default,
        _ id: AnyHashable = UUID()
    ) {
        self.frameRect = frameRect
        self.frameBehavior = frameBehavior
        self.coordinateSpace = coordinateSpace
        self.id = id
    }

    public convenience init() {
        self.init(.zero, .global, .default, UUID())
    }

    public convenience init(
        frameBehavior: FrameBehavior
    ) {
        self.init(.zero, .global, frameBehavior, UUID())
    }

    public convenience init(
        frameBehavior: FrameBehavior,
        coordinateSpace: CoordinateSpace
    ) {
        self.init(.zero, coordinateSpace, frameBehavior, UUID())
    }

    public convenience init(
        frameBehavior: FrameBehavior,
        coordinateSpace: CoordinateSpace,
        id: AnyHashable
    ) {
        self.init(.zero, coordinateSpace, frameBehavior, id)
    }

    // MARK: Public

    @Published public var id: AnyHashable

    @available(*, deprecated, renamed: "rect")
    @Published public var frameRect: CGRect
    @available(*, deprecated, renamed: "behavior")
    @Published public var frameBehavior: FrameBehavior
    @Published public var coordinateSpace: CoordinateSpace

    public static func == (lhs: IdentifiableRect, rhs: IdentifiableRect) -> Bool {
        return lhs.id == rhs.id && lhs.frameRect == rhs.frameRect
            && lhs.frameBehavior == rhs.frameBehavior && lhs.coordinateSpace == rhs.coordinateSpace
    }
}
