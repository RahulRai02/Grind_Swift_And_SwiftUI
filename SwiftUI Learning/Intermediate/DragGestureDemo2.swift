//
//  DragGestureDemo2.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 20/08/24.
//

import SwiftUI

struct DragGestureDemo2: View {
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.88
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                
                .gesture(
                DragGesture()
                    .onChanged{ value in
                        withAnimation(.spring()){
                            currentDragOffsetY = value.translation.height
                        }
                        
                    }
                    .onEnded{ value in
                        withAnimation(.spring()){
                            if currentDragOffsetY < -150 {
                                endingOffsetY = -startingOffsetY
                                currentDragOffsetY = 0
                            }else if (endingOffsetY != 0 && currentDragOffsetY > 150){
                                endingOffsetY = 0
                                currentDragOffsetY = 0
                            }else{
                                currentDragOffsetY = 0
                            }
                            
                        }
                        
                    }
                )
            Text("\(currentDragOffsetY)")
        }
        .ignoresSafeArea(edges:.bottom)
    }
}

#Preview {
    DragGestureDemo2()
}

struct MySignUpView: View {
    var body: some View {
        VStack{
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description of the app.This is the description of the app.This is the description of the app.This is the description of the app.This is the description of the app.")
                .multilineTextAlignment(.center)
            
            Text("CREATE AN ACCOUNT")
                .foregroundStyle(Color.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
