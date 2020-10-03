import SwiftUI
import DeveloperToolsSupport

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
fileprivate struct GeometryModifier: ViewModifier {
    @Binding
    var size: CGSize
    
    @Binding
    var frame: CGRect
    
    let coordinateSpace: CoordinateSpace
    
    @Binding
    var insets: EdgeInsets
    
    init(
        size: Binding<CGSize> = .constant(CGSize(width: 0, height: 0)), 
        frame: Binding<CGRect> = .constant(CGRect()), 
        coordinateSpace: CoordinateSpace = .local, 
        insets: Binding<EdgeInsets> = .constant(EdgeInsets())
    )
    {
        _size = size
        _frame = frame
        self.coordinateSpace = coordinateSpace
        _insets = insets
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader {
                    Color.clear
                        .allowsHitTesting(false)
                        .preference(key: HeightPreferenceKey.self, value: $0.size.height)
                        .preference(key: WidthPreferenceKey.self, value: $0.size.width)
                }
            )
            .onPreferenceChange(HeightPreferenceKey.self) { value in
                if value > size.height {
                    size.height = max(size.height, value)
                } else {
                    size.height = min(size.height, value)
                }
            }
            .onPreferenceChange(WidthPreferenceKey.self) { value in
                if value > size.width {
                    size.width = max(size.width, value)
                } else {
                    size.width = min(size.width, value)
                }
            }
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
public extension View {
    /// Reads the size of the modified view to a given ``CGSize`` value.
    /// This value is updated any time the size properties of its geometry
    /// are altered.
    ///
    /// In the example below, the size of the ``Text`` view, including
    /// spacing added by the ``.padding()`` modifier, is read into
    /// the "textViewSize" ``@State`` object.
    ///
    ///     @State
    ///     private var textViewSize = CGSize()
    ///     
    ///     VStack {
    ///         Text("Hello, World!")
    ///             .padding()
    ///             .readSize(to: $textViewSize)
    ///     }
    ///
    /// When reading this value to set the size of another View, 
    /// it may be a good idea to initialize ``CGSize`` with reasonable default values.
    /// This modifier first reads the value when the modified view first appears,
    /// and continues to update the value whenever the size properties of the modified
    /// view's geometry are changed. Be mindful of your view's lifecycle when using
    /// the value of this modifier to avoid endless loops.
    ///
    /// - Parameters:
    ///    - to: A bindable ``CGSize`` value to hold the size of the view.
    ///
    /// - Returns: A view which reads its current size and updates this value through
    /// a two-way ``CGSize`` binding.
    func readSize(to: Binding<CGSize>) -> some View {
        self
            .modifier(GeometryModifier(size: to))
    }
    
    /// Reads the size of the modified view to a given ``CGSize`` value.
    /// This value is updated any time the size properties of its geometry
    /// are altered.
    ///
    /// In the example below, the size of the ``Text`` view, including
    /// spacing added by the ``.padding()`` modifier, is read into
    /// the "textViewSize" ``@State`` object.
    ///
    ///     @State
    ///     private var textViewSize = CGSize()
    ///     
    ///     VStack {
    ///         Text("Hello, World!")
    ///             .padding()
    ///             .readSize(to: $textViewSize)
    ///     }
    ///
    /// When reading this value to set the size of another View, 
    /// it may be a good idea to initialize ``CGSize`` with reasonable default values.
    /// This modifier first reads the value when the modified view first appears,
    /// and continues to update the value whenever the size properties of the modified
    /// view's geometry are changed. Be mindful of your view's lifecycle when using
    /// the value of this modifier to avoid endless loops.
    ///
    /// - Parameters:
    ///    - to: A ``Binding<CGSize>`` value to store the size of the view.
    ///
    /// - Returns: A view which reads its current size and updates this value through
    /// a two-way ``CGSize`` binding.
    func readFrame(to: Binding<CGRect>, in: CoordinateSpace) -> some View {
        self
            .modifier(GeometryModifier(frame: to, coordinateSpace: `in`))
    }
    
    /// Reads the size of the modified view to a given ``CGSize`` value.
    /// This value is updated any time the size properties of its geometry
    /// are altered.
    ///
    /// In the example below, the size of the ``Text`` view, including
    /// spacing added by the ``.padding()`` modifier, is read into
    /// the "textViewSize" ``@State`` object.
    ///
    ///     @State
    ///     private var textViewSize = CGSize()
    ///     
    ///     VStack {
    ///         Text("Hello, World!")
    ///             .padding()
    ///             .readSize(to: $textViewSize)
    ///     }
    ///
    /// When reading this value to set the size of another View, 
    /// it may be a good idea to initialize ``CGSize`` with reasonable default values.
    /// This modifier first reads the value when the modified view first appears,
    /// and continues to update the value whenever the size properties of the modified
    /// view's geometry are changed. Be mindful of your view's lifecycle when using
    /// the value of this modifier to avoid endless loops.
    ///
    /// - Parameters:
    ///    - to: A ``Binding<CGSize>`` value to store the size of the view.
    ///
    /// - Returns: A view which reads its current size and updates this value through
    /// a two-way ``CGSize`` binding.
    func readInsets(to: Binding<EdgeInsets>) -> some View {
        self
            .modifier(GeometryModifier(insets: to))
    }
}
