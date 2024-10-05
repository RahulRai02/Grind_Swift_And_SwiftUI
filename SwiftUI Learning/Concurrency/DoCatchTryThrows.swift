//
//  DoCatchTryThrows.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 03/10/24.
//

import SwiftUI

class DoCatchTryThrowsManager{
    let isActive: Bool = false
    
    func getTitle() -> (title:String?, error: Error?){
        if isActive{
            return ("New Text", nil)
        }else{
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        // Either return success or an error. NOt both unlike getTitle()
        if isActive{
            return .success("New text")
        }else{
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String{
        // SO now we dont have to switch on error if we dont get the String, just theow out the error
        if isActive {
            return "New text"
        }else{
            throw URLError(.badServerResponse)
        }
    }
    
    
}


class DoCatchTryThrowsViewModel: ObservableObject {
    @Published var text: String = "Hello World"
    
    let manager = DoCatchTryThrowsManager()
    
    func fetchTitle(){
//        let returnedValue = manager.getTitle()
//        if let newTitle = returnedValue.title {
//            self.text = newTitle
//        }else if let error = returnedValue.error{
//            self.text = error.localizedDescription
//        }
        
//        let result = manager.getTitle2()
//        switch result {
//        case .success(let newTitle):
//            self.text = newTitle
//        case .failure(let error):
//            self.text = error.localizedDescription
//        }
        
        
        do{
            let newTitle = try manager.getTitle3()
            self.text = newTitle
        }catch let error{
            self.text = error.localizedDescription
        }
        

    }
    

    
}

struct DoCatchTryThrows: View {
    @StateObject private var viewModel = DoCatchTryThrowsViewModel()
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                print("Tapped")
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrows()
}
