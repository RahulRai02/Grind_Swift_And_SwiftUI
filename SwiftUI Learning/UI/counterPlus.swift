//
//  counterPlus.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 11/01/26.
//

 
import SwiftUI

class counterPlusViewModel : ObservableObject {
    @Published var count: Int = 0
    
    func resetCounter() {
        self.count = 0
    }
}

struct counterPlus: View {
    @StateObject var vm = counterPlusViewModel()
        
    var body: some View {
        VStack(spacing: 50) {
            Image(systemName: "plus")
                .foregroundColor(Color.white)
                .font(.headline)
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
                                    Text("\(vm.count)")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                )
                            ,alignment: .bottomTrailing
                        )
                        .allowsHitTesting(false)

                )
                .onTapGesture {
                    vm.count += 1
                }
            Button {
                vm.resetCounter()
            } label: {
                Text("Reset")
            }

        }
        

    }
}

#Preview {
    counterPlus()
}

