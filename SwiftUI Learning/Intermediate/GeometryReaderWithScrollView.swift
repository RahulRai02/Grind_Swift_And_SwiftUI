//
//  GeometryReaderWithScrollView.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 21/08/24.
//

import SwiftUI

struct GeometryReaderWithScrollView: View {
    
    func getPercentage(geo: GeometryProxy) -> Double{
        let maxDistance = UIScreen.main.bounds.width / 2    // get the center of the screen
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    

    var body: some View {

            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(0..<20){ index in
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 20)
                                .rotation3DEffect(
                                    Angle(degrees: getPercentage(geo: geometry) * 40),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                            
                        }
                        .frame(width: 300, height: 250)
                        .padding()
                    }
                    
                }
            }
        
    }
}

#Preview {
    GeometryReaderWithScrollView()
}
