//
//  LibraryContentItems.swift
//  
//
//  Created by Donavon Buchanan on 10/2/20.
//
import SwiftUI

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
struct LibraryModifierContent: LibraryContentProvider {
    @Binding
    var size: CGSize
    
    @Binding
    var frame: CGRect
    
    let coordinateSpace: CoordinateSpace
    
    @Binding
    var insets: EdgeInsets
    
    @LibraryContentBuilder
    func modifiers(base: AnyView) -> [LibraryItem] {
        LibraryItem(base.readSize(to: $size), visible: true, title: "Read Size", category: .layout)
        LibraryItem(base.readFrame(to: $frame, in: coordinateSpace), visible: true, title: "Read Frame", category: .layout)
        LibraryItem(base.readInsets(to: $insets), visible: true, title: "Read Insets", category: .layout)
    }
}
