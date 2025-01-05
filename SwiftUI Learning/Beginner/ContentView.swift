//
//  ContentView.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 16/08/24.
//

import SwiftUI

struct ContentView: View {
    @State var isComplete : Bool = false
    @State var isSuccess: Bool = false
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
                
              
            HStack{
                Text("Click Here")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)

                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 50, perform: {
                        withAnimation(.easeInOut){
                            isSuccess = true
                        }
                    }, onPressingChanged: { isPressing in
                        if isPressing {
                            withAnimation(.easeInOut){
                                isComplete = true
                            }
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                if !isSuccess {
                                    withAnimation(.easeInOut){
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    })
                

                Text("Reset")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            isSuccess = false
                            isComplete = false
                        }
           
                    }
            }
        }
       
    }
}

#Preview {
    ContentView()
}
