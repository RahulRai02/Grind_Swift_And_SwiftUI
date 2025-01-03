//
//  4_MatchedGeometryEffect.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 03/01/25.
//

import SwiftUI

/*
 MatchedGeometryEffect allows us to animate geometric shapes on the screen and specially allows us to morph one shape into another shape.
 
 */


struct __MatchedGeometryEffect: View {
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    var body: some View {
        VStack{
            if !isClicked{
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }
           
            Spacer()
            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 300)
            }
 
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut){
                isClicked.toggle()
            }
        }
    }
}

// Smooth recatngle transisiton while changing categoory selection
struct MatchedGeometryEffectExample2: View {
    let categories = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace2
    var body: some View{
        HStack{
            ForEach(categories, id: \.self) { category in
                ZStack{
                    if selected == category{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "category_background", in: namespace2)
                    }
            
                    Text(category)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()){
                        selected = category
                    }
                    
                }
            }
        }
        .padding()
    }
}

// Underline effecr while switching categories...
struct MatchedGeometryEffectExample3: View {
    let categories = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace3
    var body: some View{
        HStack{
            ForEach(categories, id: \.self) { category in
                ZStack{
                    if selected == category{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "category_background_3", in: namespace3)
                            .frame(width: 35, height: 2)
                            .offset(y:10)
                    }
            
                    Text(category)
                        .foregroundStyle(selected == category ? .red : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()){
                        selected = category
                    }
                    
                }
            }
        }
        .padding()
    }
}
#Preview {
    MatchedGeometryEffectExample3()
}
