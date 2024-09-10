//
//  GeometryPreferenceKey.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 09/09/24.
//

import SwiftUI

struct GeometryPreferenceKey: View {
    @State private var rectSize: CGSize = .zero
    var body: some View {
        VStack{
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack{
                Rectangle()
                GeometryReader{ geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
//                        .overlay(
//                            Text("\(geo.size.width)").foregroundStyle(Color.white)
//                        )
                }
                
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self, perform: { value in
            self.rectSize = value
        })
        
    }
    
}

#Preview {
    GeometryPreferenceKey()
}

extension View{
    func updateRectangleGeoSize(_ size: CGSize) -> some View{
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey{
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    
    
}
