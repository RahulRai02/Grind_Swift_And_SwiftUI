//
//  ImageAsyncAwait.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 03/10/24.
//

import SwiftUI

class DownloadImageAysncLoader{
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage?{
        guard
            let data = data,
            let image = UIImage(data: data), // Remember this in case of images
            let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    
    // WAY1: DOWNLOAD IMAGE USING ESCAPING
    func downloadImageWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    //WAY2 : DOWNLOAD WITH COMBINE PENDING RN.. LEARNING
    
    
    // WAY3: Download with async
    // So why its bettter? No need to say about weak self explicitly 
    func downloadWithAsync() async throws -> UIImage?{
        // await in layman terms is kind of a suspension point during exection waiting for the result to come back and the continue its exectuoin
        do {
            let (data, response) =  try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
        
    }
    
}

class ImageAsyncAwaitViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let loader = DownloadImageAysncLoader()
    
    // WAY1
    func fetchImage(){
        loader.downloadImageWithEscaping { [weak self] image, error in
            if let image = image {
//                self?.image = image
                
                // Well since URLSession.shared.dataTask runs on background thread, we need to bring it on the main thread before updating the image
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
    // WAY 3
    func fetchImage2() async {
        let image = try? await loader.downloadWithAsync()
        await MainActor.run {
            // MainActor is kind of run the below part on the main thread
            self.image = image
        }
        
    }
    
}

struct ImageAsyncAwait: View {
    @StateObject private var viewModel = ImageAsyncAwaitViewModel()
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear{
            /*
            // WAY1
            viewModel.fetchImage()
            */
            
            Task{
                // USED TASK TO GET INTO ASYNCHROUNOUS CONTEXT
                await viewModel.fetchImage2()
            }
        }

    }
}

#Preview {
    ImageAsyncAwait()
}
