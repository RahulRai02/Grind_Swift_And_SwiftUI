//
//  20_EscapingBootCamp.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 06/10/24.
//

import SwiftUI

class _0_EscapingBootCampViewModel: ObservableObject{
    @Published var text: String = "Hellow"
    
    func getData(){
        
        /* WAY1
        let newData = downloadData2()
        text = newData
        */
        
        /*
        //WAY2
        // How to use completion handler using downloadData2 function
        downloadData2 { data in
            text = data
        }
        */
        
        /*
        // WAY3
        downloadData3 { [weak self] data in
            //            self.text = data    // option 1
            // Why did i use a self keyword here??? Basically self keyword is creating a strong reference to the _0_EscapingBootCampViewModel class so it does not matter if we switch to another view in the meantime the data is loaded or net, it will get loaded in backgeound and it would not deinit the class itself...
            // So if we use a weak self on it, it means if we switch to another view and the data is not loaded it will stop loading the data if we went to other view....
            
            // Bascailly weak self is preffered because it puts less burden on the app because it will load things if absolutely necessart and would cancel unncesssart taks if we switch the view
            
            self?.text = data
        }
         */
        
        downloadData4 { [weak self] returnedData in
            self?.text = returnedData.data
        }
        
        // Way5
        downloadData5 { [weak self] returnedData in
            self?.text = returnedData.data
        }
    }
    
    // WAY1
    func downloadData() -> String{
        // -> This type of things is used for synchronous code where the code will run line by line and return at the end
        return "New data!"
    }
    
    // Actually there should be network calls in this function but for now we will just mimic using Dispatch Queue
    func downloadData2(completionHandler: (_ data: String) -> ()) {
        
        /*
        func downloadData2() -> String {
        // Below 3 lines of code wont work, because the below result will come after 2 seconds and our function demands the string immediately... So we need to fix this or mark our function asynchronous
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            return "New data2"
        }
        */
        
        // Use completionHandler
        completionHandler("New data 222!!")
    }
    
    // WAY3 
    //USING ESCAPING because our content will be async here
    // SO we use the keyword escaping because we need to make the context of the function outside as async, it does not know that something async is going to be executed outside...
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            completionHandler("Data after 3 seconds bruhhhh")
        }
    }
    
    
    // THIS WAY4 WILL SHOW, HOW TO FOLLOW INDUSTRY STANDARDS
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let result = DownloadResult(data: "New data after 3 seconds")
            completionHandler(result)
        }
    }
    
    // WAY5
    func downloadData5(completionHandler: @escaping DownloadCompletion){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let result = DownloadResult(data: "New data after 3 seconds")
            completionHandler(result)
        }
    }
}
// WAY4
struct DownloadResult {
    let data: String
}

// WAY5
typealias DownloadCompletion = (DownloadResult) -> ()

struct _0_EscapingBootCamp: View {
    @StateObject var vm = _0_EscapingBootCampViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(Color.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    _0_EscapingBootCamp()
}
