//
//  ViewExtensions.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

extension View {
    // MARK: - Read Frame

    /// Reads the properties of the modified view into an `SGObject` object.
    /// This object is updated any time the geometric properties of the modified
    /// view are altered.
    ///
    /// In the example below, the first`.readFrame` modifier returns a view who's bounds
    /// have been extended to fill its parent view. Additionally, it updates the value of a `CGRect`
    /// to match the size and position of the contents of the outermost`VStack`.
    /// These values are then displayed by the `Text` views.
    ///
    ///     /*
    ///     Create a @StateObject of type SGObject to hold all the
    ///     properties needed for the .readFrame modifier.
    ///     */
    ///     @StateObject
    ///     private var vStackSGObject = SGObject(behavior: .fill)
    ///
    ///     /*
    ///      Similar to the above, create a @StateObject of type SGObject
    ///      to hold all the properties needed for the .readFrame modifier, this
    ///      time using the default initializer values.
    ///      */
    ///     @StateObject
    ///     private var outerVStackSGObject = SGObject()
    ///
    ///     var body: some View {
    ///         VStack(alignment: .leading, spacing: 20) {
    ///             // X Axis
    ///             VStack(alignment: .leading) {
    ///                 Text("minX: \(vStackSGObject.rect.minX)")
    ///                 Text("midX: \(vStackSGObject.rect.midX)")
    ///                 Text("maxX: \(vStackSGObject.rect.maxX)")
    ///             }
    ///
    ///             // Y Axis
    ///             VStack(alignment: .leading) {
    ///                 Text("minY: \(vStackSGObject.rect.minY)")
    ///                 Text("midY: \(vStackSGObject.rect.midY)")
    ///                 Text("maxY: \(vStackSGObject.rect.maxY)")
    ///             }
    ///
    ///             // Inner VStack Size
    ///             VStack(alignment: .leading) {
    ///                 Text("Contents Width: \(vStackSGObject.rect.width)")
    ///                 Text("Contents Height: \(vStackSGObject.rect.height)")
    ///             }
    ///
    ///             // Outer VStack Size
    ///             VStack(alignment: .leading) {
    ///                 Text("Full Width: \(outerVStackSGObject.rect.width)")
    ///                 Text("Full Height: \(outerVStackSGObject.rect.height)")
    ///             }
    ///         }
    ///         .font(.system(.body, design: .monospaced))
    ///         // Blue border for illustration. This is the size being read.
    ///         .border(Color.blue, width: 2)
    ///         // Read size for contents of the VStack, filling the view
    ///         .readFrame(to: vStackSGObject)
    ///         // Red border for illustratrion. This is the size of the filled view.
    ///         .border(Color.red, width: 2)
    ///         // Read the size of the previously filled view
    ///         .readFrame(to: outerVStackSGObject)
    ///     }
    ///
    /// - Important:
    /// A note on FrameBehavior:
    /// Using a FrameBehavior value of `.fill` will still only read the size of the original contents
    /// in the modified view while extending the frame to fill all available space.
    /// If you need to read the full size of this extended frame, use this modifier a second time to
    /// read the fully extended size of the first.
    ///
    /// - Parameters:
    ///    - to: An observable object of type `SGObject` to hold all the
    ///    properties necessary for the `.readFrame` modifier. The properties within this object
    ///    are Published and can be individually observed.
    ///
    /// - Returns: A modified view which reads its current size and updates this value through
    /// the `rect` property of the `SGObject` object.

    public func readFrame(
        to sgObject: SGObject
    ) -> some View {
        self
            .modifier(SGModifier(to: sgObject))
    }
}
