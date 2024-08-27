//
//  AnimationDemo.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 21/08/24.
//

import SwiftUI

struct AnimationDemo: View {
    @State var isAnimated: Bool = false
    var body: some View {
        Button("Animate") {
            withAnimation(
                Animation
                    .default
                    .repeatForever(autoreverses: true)
            ){
                isAnimated.toggle()
            }
        }
        Spacer()
        RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
            .fill(isAnimated ? Color.red: Color.green)
            .frame(width: isAnimated ? 100 : 300,
                   height: isAnimated ? 100 : 300)
            .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
            .offset(y: isAnimated ? 300 : 0)
        Spacer()
    }
}

#Preview {
    AnimationDemo()
}
