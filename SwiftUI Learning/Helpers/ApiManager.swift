//
//  PracticeFile.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 04/11/24.
//

import Foundation
import SwiftUI

enum NetworkError: Error{
    case invalidURL
    case invalidResponse
}


final class APIManager {
    
    /*
     Error: Throw
     Success: Return
     */
    
    func request<T:Decodable> (urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
 


class ProductViewModel : ObservableObject {
    @Published var products: [Product] = []
    
    private let apiManager = APIManager()
    
    func fetchProducts() async {
        do {
            products = try await apiManager.request(urlString: "https://fakestoreapi.com/products")
            print(products)
        } catch {
            print("Error in fetching products \(error)")
        }
         
    }
}
    


// MARK: - WelcomeElement
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
//    let category: Category
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    
    var body: some View {
        List(viewModel.products, id: \.id) { product in
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text(product.description)
                    .font(.subheadline)
            }
        }
        .task {
            await viewModel.fetchProducts()
        }
    }
}

#Preview {
    ProductView()
}
    
