//
//  heartIconUI.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 11/01/26.
//

import SwiftUI

class heartViewModel : ObservableObject {
    @Published var isRed: Bool = false
}

struct heartIconUI: View {
    @StateObject var vm = heartViewModel()
        
    var body: some View {
        Image(systemName: "heart.fill")
            .foregroundColor(vm.isRed ? Color.red : Color.white)
            .font(.title2)
            .background(
                Circle()
                    .fill(
                        LinearGradient(colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 100, height: 100)
                    .shadow(color: Color.purple.opacity(0.8), radius: 10, x: 0, y: 10)
                    .overlay(
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 35, height: 35)
                            .overlay(
                                Text("5")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                            )
                        ,alignment: .bottomTrailing
                    )

            )
//            .scaleEffect(CGSize(width: 0.0, height: 2.0), anchor: .bottom)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    vm.isRed.toggle()
                }
            }
    }
}

#Preview {
    heartIconUI()
}
