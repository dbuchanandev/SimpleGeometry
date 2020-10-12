//
//  IdentifiedRect.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

public class SGObject: ObservableObject, Identifiable, Equatable {
    // MARK: Lifecycle

    /// Creates a new SGObject object.
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
    ///   - behavior: A `FrameBehavior` enum case value to indicate
    ///   if the view returned from the modifier should retain the default sizing behavior
    ///   as if unmodified using `.default`, or grow to fill the available space using `.fill`.
    ///   Defaults to a value of `.default` if no value is supplied.
    ///   - id: Any `Hashable` value used to ensure this object will be unique and conform
    ///   to the `Identifiable` protocol. Defaults to a value of `UUID()` if no value is supplied.
    private init(
        _ alignment: Alignment? = nil,
        _ behavior: FrameBehavior = .default,
        _ coordinateSpace: CoordinateSpace = .global,
        _ id: AnyHashable = UUID()
    ) {
        self.alignment = alignment
        self.behavior = behavior
        self.coordinateSpace = coordinateSpace
        self.id = id
    }

    // With Alignment
    public convenience init(
        alignment: Alignment?
    ) {
        self.init(
            alignment
        )
    }

    public convenience init(
        behavior: FrameBehavior
    ) {
        self.init(
            nil,
            behavior,
            .global,
            UUID()
        )
    }

    // With Alignment
    public convenience init(
        alignment: Alignment?,
        behavior: FrameBehavior
    ) {
        self.init(
            alignment,
            behavior,
            .global,
            UUID()
        )
    }

    public convenience init(
        behavior: FrameBehavior,
        coordinateSpace: CoordinateSpace
    ) {
        self.init(
            nil,
            behavior,
            coordinateSpace,
            UUID()
        )
    }

    // With Alignment
    public convenience init(
        alignment: Alignment?,
        behavior: FrameBehavior,
        coordinateSpace: CoordinateSpace
    ) {
        self.init(
            alignment,
            behavior,
            coordinateSpace,
            UUID()
        )
    }

    public convenience init(
        behavior: FrameBehavior,
        coordinateSpace: CoordinateSpace,
        id: AnyHashable
    ) {
        self.init(
            nil,
            behavior,
            coordinateSpace,
            id
        )
    }

    // With Alignment
    public convenience init(
        alignment: Alignment?,
        behavior: FrameBehavior,
        coordinateSpace: CoordinateSpace,
        id: AnyHashable
    ) {
        self.init(
            alignment,
            behavior,
            coordinateSpace,
            id
        )
    }

    // MARK: Public

    @Published public var id: AnyHashable

    @Published public var alignment: Alignment?
    @Published public var behavior: FrameBehavior
    @Published public var coordinateSpace: CoordinateSpace
    @Published public var rect: CGRect = .zero

    public static func == (lhs: SGObject, rhs: SGObject) -> Bool {
        return lhs.id == rhs.id && lhs.rect == rhs.rect
            && lhs.behavior == rhs.behavior && lhs.coordinateSpace == rhs.coordinateSpace
    }
}
