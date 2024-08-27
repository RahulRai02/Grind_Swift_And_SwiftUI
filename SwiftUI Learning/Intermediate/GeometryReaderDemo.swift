//
//  GeometryReaderDemo.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 21/08/24.
//

import SwiftUI

// Suppose we want the red part to be 2/3, so we can use frame modifier
// and use UIScreen.main.bound.width * 0.666... But here is a problem
// If we move the screen to landscape, then the red will occupy less portion because
// the UI Screen width is from the left edge to the right edge of the screen.

/// Geometry reader is expensive, Dont put too many, Use it only when necessary...

struct GeometryReaderDemo: View {
    var body: some View {
        GeometryReader {geometry in
            HStack(spacing:0){
                Rectangle()
                    .fill(Color.red)
//                    .frame(width: UIScreen.main.bounds.width * 0.66) // Other method to achive this but this wont work in landscape mode...
                    .frame(width: geometry.size.width * 0.66)
                Rectangle()
                    .fill(Color.blue)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GeometryReaderDemo()
}
