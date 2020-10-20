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
    /// geometry of a view, and to hold `CGSize` and `CGRect` values where the geometry properties
    /// are stored. Default values are provided for all parameters and will be all that's needed
    /// for typical use cases.
    /// - Parameters:
    ///   - alignment: Sets the alignment for the view's frame.
    ///   - behavior: A `FrameBehavior` case value to indicate
    ///   if the view returned from the modifier should retain the default sizing behavior
    ///   as if unmodified using `.default`, or grow to fill the available space using `.fill`.
    ///   Defaults to a value of `.default` if no value is supplied.
    ///   - coordinateSpace: Indicates the CoordinateSpace of the frame,
    ///   returning X and Y positional values relative to the view with `.local`, the
    ///   screen with `.global`, or a named area with `.named()`.
    ///   Defaults to a value of `.global` if no value is supplied.
    ///   - id: Any `Hashable` value used to ensure this object will be unique and conform
    ///   to the `Identifiable` protocol. Defaults to a value of `UUID()` if no value is supplied.
    private init(
        _ alignment: Alignment? = .none,
        _ behavior: FrameBehavior = .default,
        _ coordinateSpace: CoordinateSpace = .global,
        _ id: AnyHashable = UUID()
    ) {
        self.alignment = alignment
        self.behavior = behavior
        self.coordinateSpace = coordinateSpace
        self.id = id
    }

    /// Creates a new SGObject object.
    /// This class is intended to package together properties needed to read the
    /// geometry of a view, and to hold `CGSize` and `CGRect` values where the geometry properties
    /// are stored. Default values are provided for all parameters and will be all that's needed
    /// for typical use cases.
    /// - Parameter alignment: Sets the alignment for the view's frame.
    public convenience init(
        alignment: Alignment? = .none
    ) {
        self.init(
            alignment
        )
    }

    /// Creates a new SGObject object.
    /// This class is intended to package together properties needed to read the
    /// geometry of a view, and to hold `CGSize` and `CGRect` values where the geometry properties
    /// are stored. Default values are provided for all parameters and will be all that's needed
    /// for typical use cases.
    /// - Parameters:
    ///   - alignment: Sets the alignment for the view's frame.
    ///   - behavior: A `FrameBehavior` case value to indicate
    ///   if the view returned from the modifier should retain the default sizing behavior
    ///   as if unmodified using `.default`, or grow to fill the available space using `.fill`.
    public convenience init(
        alignment: Alignment? = .none,
        behavior: FrameBehavior
    ) {
        self.init(
            alignment,
            behavior,
            .global,
            UUID()
        )
    }

    /// Creates a new SGObject object.
    /// This class is intended to package together properties needed to read the
    /// geometry of a view, and to hold `CGSize` and `CGRect` values where the geometry properties
    /// are stored. Default values are provided for all parameters and will be all that's needed
    /// for typical use cases.
    /// - Parameters:
    ///   - alignment: Sets the alignment for the view's frame.
    ///   - behavior: A `FrameBehavior` case value to indicate
    ///   if the view returned from the modifier should retain the default sizing behavior
    ///   as if unmodified using `.default`, or grow to fill the available space using `.fill`.
    ///   - coordinateSpace: Indicates the CoordinateSpace of the frame,
    ///   returning X and Y positional values relative to the view with `.local`, the
    ///   screen with `.global`, or a named area with `.named()`.
    public convenience init(
        alignment: Alignment? = .none,
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

    /// Creates a new SGObject object.
    /// This class is intended to package together properties needed to read the
    /// geometry of a view, and to hold `CGSize` and `CGRect` values where the geometry properties
    /// are stored. Default values are provided for all parameters and will be all that's needed
    /// for typical use cases.
    /// - Parameters:
    ///   - alignment: Sets the alignment for the view's frame.
    ///   - behavior: A `FrameBehavior` case value to indicate
    ///   if the view returned from the modifier should retain the default sizing behavior
    ///   as if unmodified using `.default`, or grow to fill the available space using `.fill`.
    ///   - coordinateSpace: Indicates the CoordinateSpace of the frame,
    ///   returning X and Y positional values relative to the view with `.local`, the
    ///   screen with `.global`, or a named area with `.named()`.
    ///   - id: Any `Hashable` value used to ensure this object will be unique and conform
    ///   to the `Identifiable` protocol.
    public convenience init(
        alignment: Alignment? = .none,
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
    @Published public var size: CGSize = .zero

    /// Computed `CGFloat` value returning the width of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var width: CGFloat {
        return size.width
    }

    /// Computed `CGFloat` value returning the height of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var height: CGFloat {
        return size.height
    }

    /// Computed `CGPoint` value returning the origin point of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var origin: CGPoint {
        return rect.origin
    }

    /// Computed `CGFloat` value returning the minX value of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var minX: CGFloat {
        return rect.minX
    }

    /// Computed `CGFloat` value returning the midX value of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var midX: CGFloat {
        return rect.midX
    }

    /// Computed `CGFloat` value returning the maxX value of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var maxX: CGFloat {
        return rect.maxX
    }

    /// Computed `CGFloat` value returning the minY value of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var minY: CGFloat {
        return rect.minY
    }

    /// Computed `CGFloat` value returning the midY value of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var midY: CGFloat {
        return rect.midY
    }

    /// Computed `CGFloat` value returning the maxYValue of
    /// the measured view.
    /// Based on a Published object property and is thus also
    /// observable.
    public var maxY: CGFloat {
        return rect.maxY
    }

    public static func == (lhs: SGObject, rhs: SGObject) -> Bool {
        return lhs.id == rhs.id
            && lhs.rect == rhs.rect
            && lhs.behavior == rhs.behavior
            && lhs.coordinateSpace == rhs.coordinateSpace
            && lhs.size == rhs.size
    }
}
