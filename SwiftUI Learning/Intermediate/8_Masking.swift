//
//  8_Masking.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 28/08/24.
//


// Rating system

import SwiftUI

struct __Masking: View {
    @State var rating: Int = 0
    
    var body: some View {
        ZStack{
            cardView
        }
    }
    
    private var cardView: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 300, height: 250)
                .shadow(radius: 20)
            VStack(spacing:10){
                Text("Please rate us to improve!")
                starsView.overlay(overlayView.mask(starsView))
            }
            .padding()
        }

    }
    
    private var overlayView: some View{
        GeometryReader{ geometery in
            ZStack{
                Rectangle()
                    .foregroundStyle(Color.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometery.size.width)
            }
            
        }
        // Adding because to disable ontap gesture on the overlay view
        .allowsHitTesting(false)
    }
    
    private var starsView: some View{
        HStack{
            ForEach(1..<6){index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(Color.gray)
                    .onTapGesture {
                        withAnimation(.spring()){
                            rating = index
                        }
                    }
            }
        }
    }
    
}

#Preview {
    __Masking()
}
