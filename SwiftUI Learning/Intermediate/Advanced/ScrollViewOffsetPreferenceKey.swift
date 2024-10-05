//
//  ScrollViewOffsetPreferenceKey.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 10/09/24.
//

import SwiftUI

// Create a preference key
struct ScrollViewOffsetPreferenceKeyVal: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
    
    
}


struct ScrollViewOffsetPreferenceKey: View {
    let title: String = "New Title here!!"
    @State private var scrollViewOffset: CGFloat = 0
    var body: some View {
        ScrollView{
            VStack{
                titleLayer
                    .opacity(Double(scrollViewOffset) / 63.0)
                    .background(
                        GeometryReader{ geo in
                            Color.clear
                                .preference(key: ScrollViewOffsetPreferenceKeyVal.self, value: geo.frame(in: .global).minY)
                        }
                    )
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
        .onPreferenceChange(ScrollViewOffsetPreferenceKeyVal.self
                            , perform: { value in
            scrollViewOffset = value
        })
        .overlay(navBarLayer
            .opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
                 , alignment: .top)
    }
}

#Preview {
    ScrollViewOffsetPreferenceKey()
}


extension ScrollViewOffsetPreferenceKey{
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<30){_ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
    
}
