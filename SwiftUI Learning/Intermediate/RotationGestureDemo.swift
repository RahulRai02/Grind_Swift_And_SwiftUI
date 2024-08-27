//
//  RotationGestureDemo.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 20/08/24.
//
// Rotation Gesture not used often in deployments

import SwiftUI

// Use option button to get 2 pointers on screen for testing
struct RotationGestureDemo: View {
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue.cornerRadius(10))
            .rotationEffect(angle)
            .gesture(
            RotationGesture()
                .onChanged{ value in
                    angle = value
                }
            
                .onEnded{ value in
                    withAnimation(.spring()) {
                        angle = Angle(degrees: 0)
                    }
                }
            )
        
    }
}

#Preview {
    RotationGestureDemo()
}
