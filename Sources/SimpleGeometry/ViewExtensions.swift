//
//  ViewExtensions.swift
//  
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
public extension View {
    #if !os(macOS)
    //MARK: - Read Frame
    /// Reads the size of the modified view into a pair of `CGFloat` objects.
    /// This value is updated any time the size properties of the view's geometry
    /// are altered.
    ///
    /// In the example below, the frame of the `Rectangle` view, including
    /// is set based on the size of its parent View.
    /// The `.readSize` modifier set on the `VStack` makes the VStack
    /// fill the space available in its containing view and return the current width and
    /// height to bound `CGFloat` state objects, `rectWidth` and `rectHeight`.
    ///
    ///     // Create a State object of type CGRect for the modifier to use
    ///     // This can be initialized to any valid size
    ///     @State
    ///     private var frameRect: CGRect = .init(width: 50, height: 50)
    ///     
    ///     VStack(alignment: .center, spacing: 30) {
    ///     // Create a rectangle that's half the height
    ///     // and 1/3rd the width of the containing view
    ///         Rectangle()
    ///             .frame(
    ///                 width: rectWidth * (1 / 3),
    ///                 height: rectHeight * 0.5
    ///             )
    ///     }
    ///     .readSize(
    ///         toWidth: $rectWidth,
    ///         toHeight: $rectHeight,
    ///         fillFrame: true
    ///     )
    ///
    /// If you find that the size being read always returns as 0, try setting `fillFrame:` to `true`
    /// when using the `.readSize` modifier.
    ///
    /// - Parameters:
    ///    - toWidth: A bindable `CGFloat` value to hold the width of the view.
    ///    - toHeight: A bindable `CGFloat` value to hold the height of the view.
    ///    - fillFrame: A `Bool` constant to set the frame behavior of the modified view.
    ///
    /// - Returns: A view which reads its current size and updates this value through
    /// a two-way `CGSize` binding.
    //    func readSize(to: Binding<CGSize>, fillFrame shouldFillFrame: Bool) -> some View {
    //        self
    //            .modifier(GeometryModifier(to, shouldFillFrame))
    //    }
    
    func readFrame(
        identifiableRect: IdentifiableRect
    ) -> some View {
        self
            .modifier(GeometryModifierWithID(identifiableRect))
    }
    #endif
    
    //MARK: - Read Frame to CGRect
    /// Reads the size of the modified view into a pair of `CGFloat` objects.
    /// This value is updated any time the size properties of the view's geometry
    /// are altered.
    ///
    /// In the example below, the frame of the `Rectangle` view, including
    /// is set based on the size of its parent View.
    /// The `.readSize` modifier set on the `VStack` makes the VStack
    /// fill the space available in its containing view and return the current width and
    /// height to bound `CGFloat` state objects, `rectWidth` and `rectHeight`.
    ///
    ///     // Create a State object of type CGRect for the modifier to use
    ///     // This can be initialized to any valid size
    ///     @State
    ///     private var frameRect: CGRect = .init(width: 50, height: 50)
    ///     
    ///     VStack(alignment: .center, spacing: 30) {
    ///     // Create a rectangle that's half the height
    ///     // and 1/3rd the width of the containing view
    ///         Rectangle()
    ///             .frame(
    ///                 width: rectWidth * (1 / 3),
    ///                 height: rectHeight * 0.5
    ///             )
    ///     }
    ///     .readSize(
    ///         toWidth: $rectWidth,
    ///         toHeight: $rectHeight,
    ///         fillFrame: true
    ///     )
    ///
    /// If you find that the size being read always returns as 0, try setting `fillFrame:` to `true`
    /// when using the `.readSize` modifier.
    ///
    /// - Parameters:
    ///    - toWidth: A bindable `CGFloat` value to hold the width of the view.
    ///    - toHeight: A bindable `CGFloat` value to hold the height of the view.
    ///    - fillFrame: A `Bool` constant to set the frame behavior of the modified view.
    ///
    /// - Returns: A view which reads its current size and updates this value through
    /// a two-way `CGSize` binding.
    //    func readSize(to: Binding<CGSize>, fillFrame shouldFillFrame: Bool) -> some View {
    //        self
    //            .modifier(GeometryModifier(to, shouldFillFrame))
    //    }
    
    func readFrameToRect(
        to: Binding<CGRect>, 
        in coordinateSpace: CoordinateSpace = .global, 
        frameBehavior behavior: FrameBehavior = .default
    ) -> some View {
        self
            .modifier(GeometryModifier(to, coordinateSpace, behavior))
    }
} 
