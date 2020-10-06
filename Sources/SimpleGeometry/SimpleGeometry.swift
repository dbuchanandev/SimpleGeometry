import SwiftUI

public enum FrameBehavior {
    case `default`, fill
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
fileprivate struct GeometryModifier: ViewModifier {
    let frameBehavior: FrameBehavior
    
    @Binding
    var frameRect: CGRect
    let coordinateSpace: CoordinateSpace
    
    //MARK: - Rect Init
    init(
        _ frameRect: Binding<CGRect>,
        _ coordinateSpace: CoordinateSpace = .global,
        _ frameBehavior: FrameBehavior = .default
    )
    {
        _frameRect = frameRect
        self.frameBehavior = frameBehavior
        self.coordinateSpace = coordinateSpace
    }
    
    func body(content: Content) -> some View {
        
        ZStack {
            content
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .preference(
                                key: FrameRectPreferenceKey.self, 
                                value: geometry.frame(in: coordinateSpace)
                            )
                            .allowsHitTesting(false)
                    }
                )
                .modifier(
                    FilledFrameModifier(
                        frameBehavior: frameBehavior,
                        frameRect: frameRect
                    )
                )
                .onPreferenceChange(FrameRectPreferenceKey.self) { value in
                    dispatch(frameRect = value)
                }
        }
    }
    
    func dispatch(_ action: ()) {
        DispatchQueue(label: "PreferenceKeysQueue").async {
            action
        }
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
fileprivate struct FilledFrameModifier: ViewModifier {
    
    let frameBehavior: FrameBehavior
    let frameRect: CGRect
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch frameBehavior {
        case .fill:
            content
                .frame(
                    minWidth: frameRect.width, 
                    idealWidth: frameRect.width, 
                    maxWidth: frameBehavior == .fill ? .infinity : frameRect.width, 
                    minHeight: frameRect.height, 
                    idealHeight: frameRect.height, 
                    maxHeight: frameBehavior == .fill ? .infinity : frameRect.height
                )
        default:
            content
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
    //    func readSize(to: Binding<CGSize>, fillFrame shouldFillFrame: Bool) -> some View {
    //        self
    //            .modifier(GeometryModifier(to, shouldFillFrame))
    //    }
    
    func readFrameRect(to: Binding<CGRect>,in coordinateSpace: CoordinateSpace = .global, frameBehavior behavior: FrameBehavior = .default) -> some View {
        self
            .modifier(GeometryModifier(to, coordinateSpace, behavior))
    }
}
