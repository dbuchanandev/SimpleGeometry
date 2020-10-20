//
//  MeasuringShape.swift
//
//
//  Created by Donavon Buchanan on 10/13/20.
//

import SwiftUI

struct MeasuringShape: Shape {
    @Binding
    var size: CGSize

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(rect)
        DispatchQueue(label: "RectUpdate").async {
            /*
             Need to separate updating the State from updating the View
             */
            self.size = rect.size
        }
        return path
    }
}
