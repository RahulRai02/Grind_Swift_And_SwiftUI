//
//  ScrollViewReaderDemo.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 21/08/24.
//

import SwiftUI
    
// Scroll View reader to
struct ScrollViewReaderDemo: View {
    @State var textFieldString: String = ""
    @State var scrollToIndex: Int = 0
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldString)
                .padding()
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW"){
                if let index = Int(textFieldString) {
                    scrollToIndex = index
                }
            }
            
            ScrollView{
                ScrollViewReader { proxy in
                    
                    // This is the case when we have access to proxy, that is its in scope
    //                Button("Click to go to #49") {
    //                    withAnimation(.spring()){
    //                        proxy.scrollTo(49, anchor: nil)
    //                    }
    //                }
                    ForEach(0..<50){index in
                        Text("This is card #\(index)")
                            .font(.headline)
                            .frame(height:200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { oldValue, newValue in
                        withAnimation(.spring()){
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    ScrollViewReaderDemo()
}
