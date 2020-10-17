//
//  AnchoredViewModifier.swift
//  
//
//  Created by Donavon Buchanan on 10/14/20.
//

import SwiftUI

struct AnchoredViewModifier: ViewModifier {
    @StateObject
    private var sgObject: SGObject
    
    init(alignment: Alignment) {
        _sgObject = StateObject(wrappedValue: SGObject(alignment: alignment, behavior: .fill))
    }
    
    func body(content: Content) -> some View {
        content
            .readSize(to: sgObject)
    }
}
