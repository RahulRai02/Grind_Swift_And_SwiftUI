//
//  22_DownloadJsonUsingEscaping.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 07/10/24.
//

import SwiftUI


struct PostResponse: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class _2_DownloadJsonUsingEscapingViewModel: ObservableObject {
 
    @Published var posts: [PostResponse] = []
    
    init(){
        getPosts()
    }
    
    
    
    func getPosts() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        downloadData2(fromURL: url) { data in
            if let data = data {
                guard let newPosts = try? JSONDecoder().decode([PostResponse].self, from: data) else    {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            }else{
                print("No data returned")
            }

        }
    }

    func downloadData2(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        // dataTask -> automatically goes to background thread
        URLSession.shared.dataTask(with: url) { data, response, error in
            //Check for good data
            guard
                let data = data,
                let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else{
                print("Error loading the data from json")
                completionHandler(nil)
                return
            }
            
//            print(data)
//            let jsonstring = String(data: data, encoding: .utf8)
//            print(jsonstring)
            completionHandler(data)

        }
        .resume()
    }
    
    
    
    // Download data 1 function
    func downloadData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else{
                print("Error loading the data from json")
                return
            }
//            print(data)
//            let jsonstring = String(data: data, encoding: .utf8)
//            print(jsonstring)
            
            guard let newPosts = try? JSONDecoder().decode(PostResponse.self, from: data) else    {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.posts.append(newPosts)
            }
        }
        .resume()
    }
    
    
    
}


struct _2_DownloadJsonUsingEscaping: View {
    @StateObject var vm = _2_DownloadJsonUsingEscapingViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts){ post in
                VStack(alignment:.leading){
                Text(vm.posts.count.description)
                Text(post.title)
                    .font(.headline)
                Text(post.body)
                    .font(.headline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        
    }
}

#Preview {
    _2_DownloadJsonUsingEscaping()
}
