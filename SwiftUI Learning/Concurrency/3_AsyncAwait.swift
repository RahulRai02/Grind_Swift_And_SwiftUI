//
//  3_AsyncAwait.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 07/10/24.
//

import SwiftUI

// await bawsically creates a suspensions point awaiting for the response...
// NOTE:- YOu cant publish changes from the background thread to the UI.We need to do it on the main thread... SO below are 2 ways on how to move something back to main thread again..

// If using async keyword, you will use MainActor.run { } else if its normal context, you coudl use dispatch queue...
// How to add delay in async context--- Use Task.sleep


class AsyncAwaitViewModel: ObservableObject{
    @Published var dataArray: [String] = []
    
    
    // WAY1
    // Add title on main thread
    func addTitle(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.dataArray.append("Title1: \(Thread.current)")
        }
    }
    // Lets add the title on the background thread or what you mean a global thread
    func addTitle2(){
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0){
            let title2 = "Title2: \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title2)
                // Just to prove the point that we are on main thread here add title3
                let title3 = "Title3: \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    //WAY2
    func addAuthor1() async{
        let author1 = "Author1: \(Thread.current)"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 4_000_000_000)
        
        let author2 = "Author2: \(Thread.current)"
        
        await MainActor.run {
            self.dataArray.append(author2)
            
            let author3 = "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        }
        
        
        
        
    }
}

struct __AsyncAwait: View {
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        List{
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear{
            /*
            // WAY1
            viewModel.addTitle()
            viewModel.addTitle2()
            */
            
            // WAY2
            Task{
                await viewModel.addAuthor1()
            }
        }
    }
}

#Preview {
    __AsyncAwait()
}
