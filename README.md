# SimpleGeometry

## Description
SimpleGeometry provides a quick and easy way to get all the information provided by
SwiftUI's Geometry Reader with a simple modifier and no impact on the size of your view
by default.

SimpleGeometry makes the geometric properties of any view easily accessible throughout
your project.

## Usage

#### Available View Modifiers
```swift
/// Reads the size of the modified view into a `IndentifiableRect` object.
/// This object is updated any time the size properties of the view's geometry
/// are altered.
///
/// In the example below, the first`.readFrame` modifier fills the view and reads
/// the frame size and positions of the contents of the outermost`VStack` view containing
/// the multiple `Text` views. These values are then displayed by the `Text` views.
///
///     /*
///     Create a @StateObject of type IndentifiableRect to hold all the
///     properties needed for the .readFrame modifier
///     */
///     @StateObject
///     private var vStackRect = IdentifiableRect(frameBehavior: .fill)
///     
///     /*
///      Similar to the above, create a @StateObject of type IndentifiableRect
///      to hold all the properties needed for the .readFrame modifier, this
///      time using the default initializer values.
///      */
///     @StateObject
///     private var fullViewRect = IdentifiableRect()
///     
///     var body: some View {
///         VStack(alignment: .leading, spacing: 20) {
///             // X Axis
///             VStack(alignment: .leading) {
///                 Text("minX: \(vStackRect.frameRect.minX)")
///                 Text("midX: \(vStackRect.frameRect.midX)")
///                 Text("maxX: \(vStackRect.frameRect.maxX)")
///             }
///             
///             // Y Axis
///             VStack(alignment: .leading) {
///                 Text("minY: \(vStackRect.frameRect.minY)")
///                 Text("midY: \(vStackRect.frameRect.midY)")
///                 Text("maxY: \(vStackRect.frameRect.maxY)")
///             }
///             
///             // VStack Size
///             VStack(alignment: .leading) {
///                 Text("Contents Width: \(vStackRect.frameRect.width)")
///                 Text("Contents Height: \(vStackRect.frameRect.height)")
///             }
///             
///             // Full View Size
///             VStack(alignment: .leading) {
///                 Text("Full Width: \(fullViewRect.frameRect.width)")
///                 Text("Full Height: \(fullViewRect.frameRect.height)")
///             }
///         }
///         .font(.system(.body, design: .monospaced))
///         // Blue border for illustration. This is the size being read.
///         .border(Color.blue, width: 2)
///         // Read size for contents of the VStack, filling the view
///         .readFrame(to: vStackRect)
///         // Red border for illustratrion. This is the size of the filled view.
///         .border(Color.red, width: 2)
///         // Read the size of the previously filled view
///         .readFrame(to: fullViewRect)
///     }
///
/// - Important:
/// A note on FrameBehavior:
/// Using a FrameBehavior value of `.fill` will still only read the size for the original contents
/// of the modified view while extending the frame to fill all available space.
/// If you wish to read the full size of this extended frame, use the this modifier a second time to
/// read the full size of the first.
///
/// - Parameters:
///    - to: An observable object of type `IdentifiableRect` value to hold all the
///    properties necessar for the `.readFrame` modifier. The properties within this object
///    are Published and can be individually observed.
///
/// - Returns: A view which reads its current size and updates this value through 
/// the `frameRect` property of the `IdentifiableRect` object.

func readFrame(
to identifiableRect: IdentifiableRect
) -> some View
{
self
.modifier(GeometryModifierWithID(identifiableRect))
}

/// Reads the size of the modified view into a `CGRect` object.
/// This object is updated any time the size properties of the view's geometry
/// are altered.
///
/// In the example below, the first `.readFrameToRect` modifier fills the view and reads
/// the frame size and positions of the contents of the outermost`VStack` view containing
/// the multiple `Text` views. These values are then displayed by the `Text` views.
///
///      /*
///     Create a @State property of type CGRect initialized to .zero to hold
///     the geometry properties read by the .readFrameToRect modifier.
///     */
///     @State
///     private var vStackRect: CGRect = .zero
///     
///     /*
///      As above, create another @State property of type CGRect initialized 
///      to .zero to hold the geometry properties read by the .readFrameToRect modifier.
///      This value will hold the geometry properties of the fully filled view frame.
///      */
///     @State
///     private var fullViewRect: CGRect = .zero
///     
///     var body: some View {
///         VStack(alignment: .leading, spacing: 20) {
///             // X Axis
///             VStack(alignment: .leading) {
///                 Text("minX: \(vStackRect.minX)")
///                 Text("midX: \(vStackRect.midX)")
///                 Text("maxX: \(vStackRect.maxX)")
///             }
///             
///             // Y Axis
///             VStack(alignment: .leading) {
///                 Text("minY: \(vStackRect.minY)")
///                 Text("midY: \(vStackRect.midY)")
///                 Text("maxY: \(vStackRect.maxY)")
///             }
///             
///             // VStack Size
///             VStack(alignment: .leading) {
///                 Text("Contents Width: \(vStackRect.width)")
///                 Text("Contents Height: \(vStackRect.height)")
///             }
///             
///             // Full View Size
///             VStack(alignment: .leading) {
///                 Text("Full Width: \(fullViewRect.width)")
///                 Text("Full Height: \(fullViewRect.height)")
///             }
///         }
///         .font(.system(.body, design: .monospaced))
///         // Blue border for illustration. This is the size being read.
///         .border(Color.blue, width: 2)
///         // Read size for contents of the VStack, filling the view
///         .readFrameToRect(to: $vStackRect, in: .global, frameBehavior: .fill)
///         // Red border for illustratrion. This is the size of the filled view.
///         .border(Color.red, width: 2)
///         // Read the size of the previously filled view
///         .readFrameToRect(to: $fullViewRect)
///     }
///
/// - Important:
/// A note on FrameBehavior:
/// Using a FrameBehavior value of `.fill` will still only read the size for the original contents
/// of the modified view while extending the frame to fill all available space.
/// If you wish to read the full size of this extended frame, use the this modifier a second time to
/// read the full size of the first.
///
/// - Parameters:
///    - to: A bindable `CGRect` object to hold the geometry properties of the modified view.
///    - in: A `CoordinateSpace` value to indicates the `CoordinateSpace` of the frame,
///   returning X and Y positional values relative to the view with `.local`, the
///   screen with `.global`, or a named area with `.named()`.
///   Defaults to a value of `.global` if no value is supplied.
///    - frameBehavior: A `FrameBehavior` enum case value to indicate
///   if the view returned from the modifier should retain the default sizing behavior
///   as if unmodified using `.default`, or grow to fill the available space using `.fill`.
///   Defaults to a value of `.default` if no value is supplied.
///
/// - Returns: A view which reads its current size and updates this value through 
/// the bound `CGRect` object of the `to:` parameter.

func readFrameToRect(
to: Binding<CGRect>, 
in coordinateSpace: CoordinateSpace = .global, 
frameBehavior behavior: FrameBehavior = .default
) -> some View
{
self
.modifier(GeometryModifier(to, coordinateSpace, behavior))
}
```

#### Easiest
```swift
import SwiftUI
import SimpleGeometry

struct ExampleSwiftUIView: View {

    /*
    Create a @StateObject of type IndentifiableRect to hold all the
    properties needed for the .readFrame modifier
    */
    @StateObject
    private var vStackRect = IdentifiableRect(frameBehavior: .fill)

    /*
    Similar to the above, create a @StateObject of type IndentifiableRect
    to hold all the properties needed for the .readFrame modifier, this
    time using the default initializer values.
    */
    @StateObject
    private var fullViewRect = IdentifiableRect()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // X Axis
            VStack(alignment: .leading) {
                Text("minX: \(vStackRect.frameRect.minX)")
                Text("midX: \(vStackRect.frameRect.midX)")
                Text("maxX: \(vStackRect.frameRect.maxX)")
            }

            // Y Axis
            VStack(alignment: .leading) {
                Text("minY: \(vStackRect.frameRect.minY)")
                Text("midY: \(vStackRect.frameRect.midY)")
                Text("maxY: \(vStackRect.frameRect.maxY)")
            }

            // VStack Size
            VStack(alignment: .leading) {
                Text("Contents Width: \(vStackRect.frameRect.width)")
                Text("Contents Height: \(vStackRect.frameRect.height)")
            }

            // Full View Size
            VStack(alignment: .leading) {
                Text("Full Width: \(fullViewRect.frameRect.width)")
                Text("Full Height: \(fullViewRect.frameRect.height)")
            }
        }
        .font(.system(.body, design: .monospaced))
        // Blue border for illustration. This is the size being read.
        .border(Color.blue, width: 2)
        // Read size for contents of the VStack, filling the view
        .readFrame(to: vStackRect)
        // Red border for illustratrion. This is the size of the filled view.
        .border(Color.red, width: 2)
        // Read the size of the previously filled view
        .readFrame(to: fullViewRect)
    }

}
```

#### Alternative
```swift
import SwiftUI
import SimpleGeometry

struct ExampleSwiftUIView: View {

    /*
    Create a @State property of type CGRect initialized to .zero to hold
    the geometry properties read by the .readFrameToRect modifier.
    */
    @State
    private var vStackRect: CGRect = .zero

    /*
    As above, create another @State property of type CGRect initialized 
    to .zero to hold the geometry properties read by the .readFrameToRect modifier.
    This value will hold the geometry properties of the fully filled view frame.
    */
    @State
    private var fullViewRect: CGRect = .zero

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // X Axis
            VStack(alignment: .leading) {
                Text("minX: \(vStackRect.minX)")
                Text("midX: \(vStackRect.midX)")
                Text("maxX: \(vStackRect.maxX)")
            }

            // Y Axis
            VStack(alignment: .leading) {
                Text("minY: \(vStackRect.minY)")
                Text("midY: \(vStackRect.midY)")
                Text("maxY: \(vStackRect.maxY)")
            }

            // VStack Size
            VStack(alignment: .leading) {
                Text("Contents Width: \(vStackRect.width)")
                Text("Contents Height: \(vStackRect.height)")
            }

            // Full View Size
            VStack(alignment: .leading) {
                Text("Full Width: \(fullViewRect.width)")
                Text("Full Height: \(fullViewRect.height)")
            }
        }
        .font(.system(.body, design: .monospaced))
        // Blue border for illustration. This is the size being read.
        .border(Color.blue, width: 2)
        // Read size for contents of the VStack, filling the view
        .readFrameToRect(to: $vStackRect, in: .global, frameBehavior: .fill)
        // Red border for illustratrion. This is the size of the filled view.
        .border(Color.red, width: 2)
        // Read the size of the previously filled view
        .readFrameToRect(to: $fullViewRect)
    }

}
```

### Example Project
[SimpleGeometry-Demo - Coming Soon]()

## Contact
[Twitter: @dbuchanandev](https://twitter.com/dbuchanandev)

## License
This project is [licensed](License.txt) under the terms of the GNU GPLv3 license.
