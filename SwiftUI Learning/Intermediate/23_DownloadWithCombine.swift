//
//  23_DownloadWithCombine.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 07/10/24.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class _2_DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostResponse] = []
    
    init(){
        
    }
}

struct _3_DownloadfWithCombine: View {
    @StateObject var vm = _2_DownloadWithCombineViewModel()
    
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

//#Preview {
//    _3_DownloadWithCombine()
//}
