//
//  MagnificationGesture.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 17/08/24.
//

import SwiftUI

struct MagnificationGestureDemo: View {
    @State var currAmount : CGFloat = 0
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding()
            .background(Color.red.cornerRadius(10))
            .scaleEffect(1 + currAmount)
            .gesture(
            MagnificationGesture()
                .onChanged{ value in
                    currAmount = value - 1
                }
                .onEnded{ value in
                    withAnimation(.spring()){
                        currAmount = 0
                    }
                    
                }
                
            )
    }
}

#Preview {
    MagnificationGestureDemo()
}
