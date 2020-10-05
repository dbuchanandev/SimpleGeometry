//
//  LibraryContentItems.swift
//  
//
//  Created by Donavon Buchanan on 10/2/20.
//
#if canImport(DeveloperToolsSupport)
import SwiftUI
import DeveloperToolsSupport

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
public struct LibraryModifierContent: LibraryContentProvider {
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
    
    let shouldFillContainer: Bool = false
    
    @LibraryContentBuilder
    public func modifiers(base: AnyView) -> [LibraryItem] {
        LibraryItem(base.readSize(toWidth: $width, toHeight: $height, fill: shouldFillContainer), visible: true, title: "Read Size", category: .layout)
        LibraryItem(base.readInsets(to: $edgeInsets), visible: true, title: "Read Insets", category: .layout)
    }
}
#endif
