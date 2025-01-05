//
//  23_DownloadWithCombine.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 07/10/24.
//
// Before iOS 13 Use @escaping to download
// After iOS 13 use combine

//"https://jsonplaceholder.typicode.com/posts/1"

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
//The below function is not refactored code of ViewModel
/*
class _2_DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        // COMBINE Analogy and description
        /*
        // Analogy
        // 1. Sign up for monthly subscription for package to be delivered
        // 2. The company would make the package behind the scene.
        // 3. Receive the pacakge at your front door
        // 4. Make sure the box is not damaged
        // 5. Open and make sure the item is correct
        // 6. Use the item !!!!
        // 7. Cancellable at any time
        
        
        // 1. Create the publisher
        // 2. Subscribe the publisher on background thread...
        // 3. receive on main thread
        // 4. tryMap (Check the data is good)
        // 5. decode (Decode data into PostNModel)
        // 6. Sink (Put the item into our app)
        // 7. Store (Cancellable subscription if needed
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
            print("COMPLETION: \(completion)")
            } receiveValue: {[weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
}
*/

class _2_DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }

        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            
            .sink { (completion) in
//            print("COMPLETION: \(completion)")
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: {[weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    func handleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data{
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}


struct _3_DownloadWithCombine: View {
    @StateObject var vm = _2_DownloadWithCombineViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts){ post in
                VStack(alignment:.leading){
//                    Text(vm.posts.count.description)
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
//                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    _3_DownloadWithCombine()
}
