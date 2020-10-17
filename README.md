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
    Create a @State variable of type CGRect to hold the
    size properties needed for the .measure(to:) modifier.
    */
    @State
    private var rect: CGRect = .zero
    
    var body: some View {
    
        VStack {
            Text("Measured Width: \(rect.width)")
            Text("Measured Height: \(rect.height)")
        }
        .font(.system(.body, design: .monospaced))
        /*
         Blue border for illustration.
         This is the bounds of the View being read.
        */
        .border(Color.blue, width: 2)
        // Measure the size of this VStack
        .measure(to: $rect)
    }
}
```

### Measuring a View's containing View size without Geometry Reader
```swift
import SwiftUI
import SimpleGeometry

struct ExampleSwiftUIView: View {

    /*
    Create a @State variable of type CGRect to hold the
    size properties needed for the .measure(to:) modifier.
    */
    @State
    private var rect: CGRect = .zero
    
    var body: some View {
    
        VStack {
            Text("Container Width: \(rect.width)")
            Text("Container Height: \(rect.height)")
        }
        .font(.system(.body, design: .monospaced))
        // Measure size of the View containing this VStack
        .measureContainingView(to: $rect)
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
    private var ViewSize = SGObject()
    
    var body: some View {
    
        VStack(alignment: .leading, spacing: 20) {
            // X Axis
            VStack(alignment: .leading) {
                Text("minX: \(viewSize.rect.minX)")
                Text("midX: \(viewSize.rect.midX)")
                Text("maxX: \(viewSize.rect.maxX)")
            }
            
            // Y Axis
            VStack(alignment: .leading) {
                Text("minY: \(viewSize.rect.minY)")
                Text("midY: \(viewSize.rect.midY)")
                Text("maxY: \(viewSize.rect.maxY)")
            }
            
            // View Size
            VStack(alignment: .leading) {
                Text("Contents Width: \(viewSize.rect.width)")
                Text("Contents Height: \(viewSize.rect.height)")
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
                Text("minX: \(parentSize.rect.minX)")
                Text("midX: \(parentSize.rect.midX)")
                Text("maxX: \(parentSize.rect.maxX)")
            }

            // Y Axis
            VStack(alignment: .leading) {
                Text("minY: \(parentSize.rect.minY)")
                Text("midY: \(parentSize.rect.midY)")
                Text("maxY: \(parentSize.rect.maxY)")
            }

            // Containing View Size
            VStack(alignment: .leading) {
                Text("Contents Width: \(parentSize.rect.width)")
                Text("Contents Height: \(parentSize.rect.height)")
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
