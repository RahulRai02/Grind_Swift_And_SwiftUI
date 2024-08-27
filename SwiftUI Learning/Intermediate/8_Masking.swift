//
//  8_Masking.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 28/08/24.
//


// Rating system

import SwiftUI

struct __Masking: View {
    @State var rating: Int = 2
    
    var body: some View {
        ZStack{
            starsView
        }
    }
    
    private var starsView: some View{
        HStack{
            ForEach(1..<6){index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
    
}

#Preview {
    __Masking()
}
