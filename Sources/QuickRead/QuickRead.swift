import SwiftUI

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
fileprivate struct GeometryModifier: ViewModifier {
    @Binding
    var width: CGFloat
    
    @Binding
    var height: CGFloat
    
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
        self.shouldFillContainer = shouldFillContainer
    }
    
    func body(content: Content) -> some View {
        
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                        .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
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
    }
    
    func dispatch(_ action: ()) {
        DispatchQueue(label: "preferences").async {
            action
        }
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
public extension View {
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
    ///     @State
    ///     private var rectWidth: CGFloat = 0
    ///     
    ///     @State
    ///     private var rectHeight: CGFloat = 0
    ///     
    ///     VStack {
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
    func readSize(toWidth: Binding<CGFloat>, toHeight: Binding<CGFloat>, fillFrame shouldFillContainer: Bool) -> some View {
        self
            .modifier(GeometryModifier(toWidth, toHeight, shouldFillContainer))
    }
}
