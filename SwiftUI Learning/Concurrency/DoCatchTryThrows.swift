//
//  DoCatchTryThrows.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 03/10/24.
//

import SwiftUI

class DoCatchTryThrowsManager {
    let isActive: Bool = false
    
    /* WAY1
     
    // Below getTitle code is problematic since it returns nil if isActive is false... But ideally it should return an error inplace of nil
    func getTitle() -> String?{
        if isActive {
           return "New Text"
        }else{
            return nil
        }
    }
    */
    
    /*
    // WAY2
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New Text", nil)
        }else{
            return (nil, URLError(.badURL))
        }
    }
     */
    
    /*
    // WAY 3
    // Well so here we are returning either a success or an error. So why return both?? When we could just return one of them
    func getTitle2() -> Result<String, Error> {
        if isActive{
            return .success("New text")
        }else {
            return .failure(URLError(.badURL))
        }
    }
    
    */
    
    // WAY4
    func getTitle3() throws -> String {
        // why mark it with throw??? So instead of returning nil, we could throw out an error
        if isActive {
            return "New text it is"
        }else{
            throw URLError(.backgroundSessionWasDisconnected)
        }
    }
    
}


class DoCatchTryThrowsViewModel: ObservableObject {
    @Published var text: String = "Hello world for now"
    let manager = DoCatchTryThrowsManager()
    
    
    func fetchTitle(){
        /* WAY1
        let newTitle = manager.getTitle()
        if let newTitle = newTitle {
            self.text = newTitle
        }
         */
        
        /* WAY2
        let returnedValue = manager.getTitle()
        if let newTitle = returnedValue.title {
            self.text = newTitle
        }else if let error = returnedValue.error{
            self.text = error.localizedDescription
        }
        */
        
        /*
        // WAY3
        let result = manager.getTitle2()
        
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
         
        */
        
        // WAY4
        // IF YOU fail any of the try statement you wil go to the catch block for sure
        
        // Optional try: No need to use do catch. Use it when you dont care about the error, you jsut want the success case ... try?
        do {
            self.text =  try manager.getTitle3()
        } catch let error {
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
