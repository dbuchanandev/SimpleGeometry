import SwiftUI
import DeveloperToolsSupport

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
fileprivate struct GeometryModifier: ViewModifier {
    @Binding
    var height: CGFloat
    
    @Binding
    var width: CGFloat
    
    @Binding
    var x: CGFloat
    
    @Binding
    var y: CGFloat
    
    let coordinateSpace: CoordinateSpace
    
    @Binding
    var edgeInsets: EdgeInsets
    
    init(
        _ height: Binding<CGFloat> = .constant(CGFloat(0)),
        _ width: Binding<CGFloat> = .constant(CGFloat(0))
    )
    {
        _height = height
        _width = width
        _x = .constant(CGFloat(0))
        _y = .constant(CGFloat(0))
        self.coordinateSpace = .local
        _edgeInsets = .constant(EdgeInsets())
    }
    
    init(
        _ x: Binding<CGFloat> = .constant(CGFloat(0)),
        _ y: Binding<CGFloat> = .constant(CGFloat(0)),
        _ coordinateSpace: CoordinateSpace = .local
    )
    {
        _height = .constant(CGFloat(0))
        _width = .constant(CGFloat(0))
        _x = x
        _y = y
        self.coordinateSpace = coordinateSpace
        _edgeInsets = .constant(EdgeInsets())
    }
    
    init(
        _ insets: Binding<EdgeInsets> = .constant(EdgeInsets())
    )
    {
        _height = .constant(CGFloat(0))
        _width = .constant(CGFloat(0))
        _x = .constant(CGFloat(0))
        _y = .constant(CGFloat(0))
        self.coordinateSpace = .local
        _edgeInsets = insets
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader {
                    Color.clear
                        .allowsHitTesting(false)
                        .preference(key: HeightPreferenceKey.self, value: $0.size.height)
                        .preference(key: WidthPreferenceKey.self, value: $0.size.width)
                        .preference(key: OriginXPreferenceKey.self, value: $0.frame(in: coordinateSpace).origin.x)
                        .preference(key: OriginYPreferenceKey.self, value: $0.frame(in: coordinateSpace).origin.y)
                        .preference(key: EdgeInsetsPreferenceKey.self, value: $0.safeAreaInsets)
                }
            )
            .onPreferenceChange(HeightPreferenceKey.self) { value in
                if value > height {
                    height = max(height, value)
                }
                if value < height {
                    height = min(height, value)
                }
            }
            .onPreferenceChange(WidthPreferenceKey.self) { value in
                if value > width {
                    width = max(width, value)
                } 
                if value < width {
                    width = min(width, value)
                }
            }
            .onPreferenceChange(OriginXPreferenceKey.self, perform: { value in
                if value > x {
                    x = max(x, value)
                } 
                if value < x {
                    x = min(x, value)
                }
            })
            .onPreferenceChange(OriginYPreferenceKey.self, perform: { value in
                if value > y {
                    y = max(y, value)
                } 
                if value < y {
                    y = min(y, value)
                }
            })
            .onPreferenceChange(EdgeInsetsPreferenceKey.self, perform: { value in
                edgeInsets = value
            })
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
    func readSize(height: Binding<CGFloat>, width: Binding<CGFloat>) -> some View {
        self
            .modifier(GeometryModifier(height, width))
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
    ///    - to: A bindable ``CGSize`` value to hold the size of the view.
    ///
    /// - Returns: A view which reads its current size and updates this value through
    /// a two-way ``CGSize`` binding.
    func readPosition(x: Binding<CGFloat>, y: Binding<CGFloat>, coordinateSpace: CoordinateSpace) -> some View {
        self
            .modifier(GeometryModifier(x, y, coordinateSpace))
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
    func readInsets(to insets: Binding<EdgeInsets>) -> some View {
        self
            .modifier(GeometryModifier(insets))
    }
}
