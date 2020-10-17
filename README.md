# SimpleGeometry

## Description
SimpleGeometry provides a quick and easy way to get all the information provided by
SwiftUI's Geometry Reader with a simple modifier and no impact on the size of your view
by default.

SimpleGeometry makes the geometric properties of any view easily accessible throughout
your project.

###### Important Note:
Building for macOS requires macOS 11.0 or newer and Xcode 12.1 or newer.

## Usage
### Measuring a View's size without Geometry Reader
```swift
import SwiftUI
import SimpleGeometry

struct ExampleSwiftUIView: View {

    /*
    Create a @State variable of type `CGSize` to hold the
    size properties needed for the .measure(to:) modifier.
    */
    @State
    private var size: CGRect = .zero
    
    var body: some View {
    
        VStack {
            Text("Measured Width: \(size.width)")
            Text("Measured Height: \(size.height)")
        }
        .font(.system(.body, design: .monospaced))
        /*
         Blue border for illustration.
         This is the bounds of the View being read.
        */
        .border(Color.blue, width: 2)
        // Measure the size of this VStack
        .measure(to: $size)
    }
}
```

### Measuring a View's containing View size without Geometry Reader
```swift
import SwiftUI
import SimpleGeometry

struct ExampleSwiftUIView: View {

    /*
    Create a @State variable of type `CGSize` to hold the
    size properties needed for the .measure(to:) modifier.
    */
    @State
    private var size: CGSize = .zero
    
    var body: some View {
    
        VStack {
            Text("Container Width: \(size.width)")
            Text("Container Height: \(size.height)")
        }
        .font(.system(.body, design: .monospaced))
        // Measure size of the View containing this VStack
        .measureContainingView(to: $size)
    }
}
```

### Reading the geometry of a View
```swift
import SwiftUI
import SimpleGeometry

struct ExampleSwiftUIView: View {

    /*
    Create a @StateObject of type SGObject to hold all the
    properties needed for the .readSize modifier.
    */
    @StateObject
    private var viewSize = SGObject()
    
    var body: some View {
    
        VStack(alignment: .leading, spacing: 20) {
            // X Axis
            VStack(alignment: .leading) {
                Text("minX: \(viewSize.minX)")
                Text("midX: \(viewSize.midX)")
                Text("maxX: \(viewSize.maxX)")
            }
            
            // Y Axis
            VStack(alignment: .leading) {
                Text("minY: \(viewSize.minY)")
                Text("midY: \(viewSize.midY)")
                Text("maxY: \(viewSize.maxY)")
            }
            
            // View Size
            VStack(alignment: .leading) {
                Text("Contents Width: \(viewSize.width)")
                Text("Contents Height: \(viewSize.height)")
            }
        }
        .font(.system(.body, design: .monospaced))
        // Blue border for illustration. This is the size being read.
        .border(Color.blue, width: 2)
        // Read size for contents of the VStack
        .readSize(to: viewSize)
    }
}
```

### Reading the geometry of a View's containing View
```swift
import SwiftUI
import SimpleGeometry

struct ExampleSwiftUIView: View {

    /*
    Create a @StateObject of type SGObject to hold all the
    properties needed for the .readParentSize modifier.
    */
    @StateObject
    private var parentSize = SGObject()

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {
            // X Axis
            VStack(alignment: .leading) {
                Text("minX: \(parentSize.minX)")
                Text("midX: \(parentSize.midX)")
                Text("maxX: \(parentSize.maxX)")
            }

            // Y Axis
            VStack(alignment: .leading) {
                Text("minY: \(parentSize.minY)")
                Text("midY: \(parentSize.midY)")
                Text("maxY: \(parentSize.maxY)")
            }

            // Containing View Size
            VStack(alignment: .leading) {
                Text("Contents Width: \(parentSize.width)")
                Text("Contents Height: \(parentSize.height)")
            }

        }
        .font(.system(.body, design: .monospaced))
        .readParentSize(to: parentSize)
    }
}
```

### Example Project
[SimpleGeometry-Demo](https://github.com/donavoncade/SimpleGeometry-Demo)

## Contact
[Twitter: @dbuchanandev](https://twitter.com/dbuchanandev)

## License
This project is [licensed](License.txt) under the terms of the GNU GPLv3 license.
