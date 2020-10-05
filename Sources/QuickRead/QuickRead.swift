import SwiftUI

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
fileprivate struct GeometryModifier: ViewModifier {
    @Binding
    var width: CGFloat
    
    @Binding
    var height: CGFloat
    
    @Binding
    var x: CGFloat
    
    @Binding
    var y: CGFloat
    
    let coordinateSpace: CoordinateSpace
    
    @Binding
    var edgeInsets: EdgeInsets
    
    let shouldFillContainer: Bool
    
    // MARK: - Size
    init(
        _ width: Binding<CGFloat> = .constant(CGFloat(0)),
        _ height: Binding<CGFloat> = .constant(CGFloat(0)),
        _ shouldFillContainer: Bool = false
    )
    {
        _width = width
        _height = height
        _x = .constant(CGFloat(0))
        _y = .constant(CGFloat(0))
        self.coordinateSpace = .global
        _edgeInsets = .constant(EdgeInsets())
        self.shouldFillContainer = shouldFillContainer
    }
    
    // MARK: - Position
    init(
        _ x: Binding<CGFloat> = .constant(CGFloat(0)),
        _ y: Binding<CGFloat> = .constant(CGFloat(0)),
        _ coordinateSpace: CoordinateSpace = .global
    )
    {
        _width = .constant(CGFloat(0))
        _height = .constant(CGFloat(0))
        _x = x
        _y = y
        self.coordinateSpace = coordinateSpace
        _edgeInsets = .constant(EdgeInsets())
        self.shouldFillContainer = false
    }
    
    // MARK: - Insets
    init(
        _ insets: Binding<EdgeInsets> = .constant(EdgeInsets())
    )
    {
        _width = .constant(CGFloat(0))
        _height = .constant(CGFloat(0))
        _x = .constant(CGFloat(0))
        _y = .constant(CGFloat(0))
        self.coordinateSpace = .global
        _edgeInsets = insets
        self.shouldFillContainer = false
    }
    
    func body(content: Content) -> some View {
        
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                        .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
                        .preference(key: OriginXPreferenceKey.self, value: geometry.frame(in: coordinateSpace).minX)
                        .preference(key: OriginYPreferenceKey.self, value: geometry.frame(in: coordinateSpace).minY)
                        .preference(key: EdgeInsetsPreferenceKey.self, value: geometry.safeAreaInsets)
                        .allowsHitTesting(false)
                }
            )
            .frame(minWidth: 0, idealWidth: width, maxWidth: shouldFillContainer ? .infinity : width, minHeight: 0, idealHeight: height, maxHeight: shouldFillContainer ? .infinity : height)
            .onPreferenceChange(WidthPreferenceKey.self) { value in
                dispatch(width = value)
            }
            .onPreferenceChange(HeightPreferenceKey.self) { value in
                dispatch(height = value)
            }
            .onPreferenceChange(EdgeInsetsPreferenceKey.self, perform: { value in
                dispatch(edgeInsets = value)
            })
    }
    
    func dispatch(_ action: ()) {
        DispatchQueue(label: "preferences").async {
            action
        }
    }
}

@available(iOS 13.0, macOS 10.15, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
extension GeometryProxy: Equatable {
    @available(iOS 13.0, macOS 10.15, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func == (lhs: GeometryProxy, rhs: GeometryProxy) -> Bool {
        return
            lhs.safeAreaInsets == rhs.safeAreaInsets &&
            lhs.size == rhs.size &&
            lhs.frame(in: .global) == lhs.frame(in: .global)
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
    func readSize(toWidth: Binding<CGFloat>, toHeight: Binding<CGFloat>, fillFrame shouldFillContainer: Bool) -> some View {
        self
            .modifier(GeometryModifier(toWidth, toHeight, shouldFillContainer))
    }
    /*
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
     */
    
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
