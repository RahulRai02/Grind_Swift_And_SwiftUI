//
//  DragGestureDemo.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 20/08/24.
//

import SwiftUI

// MARK- UNCOMMENT  this to for part 1 demo
//struct DragGestureDemo: View {
//    
//    @State var offset: CGSize = .zero
//    var body: some View {
//        RoundedRectangle(cornerRadius: 20)
//            .frame(width: 100, height: 100)
//            .offset(offset)
//            .gesture(
//            DragGesture()
//                .onChanged{ value in
//                    withAnimation(.easeInOut){
//                        offset = value.translation
//                    }
//                    
//                }
//                .onEnded{ value in
//                    withAnimation(.easeInOut){
//                        offset = .zero
//                    }
//                }
//            )
//    }
//}

// How to BUmble/ Tinder type swipe gestures
struct DragGestureDemo: View {
    
    @State var offset: CGSize = .zero
    var body: some View {
        ZStack {
            VStack{
                Text("\(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                DragGesture()
                    .onChanged{ value in
                        withAnimation(.easeInOut){
                            offset = value.translation
                        }
                        
                    }
                    .onEnded{ value in
                        withAnimation(.easeInOut){
                            offset = .zero
                        }
                    }
            )
        }
    }
    func getScaleAmount() -> CGFloat{
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5  // Bevause we dont want to scale it down to 0
    }
    func getRotationAmount() -> Double{
        let max = UIScreen.main.bounds.width/2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    DragGestureDemo()
}
