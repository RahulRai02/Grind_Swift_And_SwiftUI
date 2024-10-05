//
//  ImageAsyncAwait.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 03/10/24.
//

import SwiftUI

class DownloadImageAysncLoader{
    let url = URL(string: "https://picsum.photos/200")
    
    func downloadImage() async throws -> UIImage?{
        do{
            let (data, response) = try await URLSession.shared.data(from: url!)
            
            guard let image = UIImage(data: data) else {
                throw URLError(.badServerResponse)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else{
                return nil
            }
            return image
            
        }catch{
            throw error
        }
    }
}

class ImageAsyncAwaitViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let loader = DownloadImageAysncLoader()
    
    func fetchImage() async throws{
//        do{
            self.image = try? await loader.downloadImage()
      
        
        
    }
    
}

struct ImageAsyncAwait: View {
    @StateObject private var viewModel = ImageAsyncAwaitViewModel()
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear{
            Task{
                try await viewModel.fetchImage()
            }
        }

    }
}

#Preview {
    ImageAsyncAwait()
}
