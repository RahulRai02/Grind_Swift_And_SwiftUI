//
//  DownloadDataFromNet.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 05/01/25.
//

import SwiftUI
import Combine

struct WeatherResponse: Codable{
    let coordinate: Coordinate
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case weather
    }
}

struct Coordinate: Codable{
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main,description, icon
    }
    
}


class DownloadDataFromNetViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse? = nil
    var cancellables = Set<AnyCancellable>()
    let url = "https://api.openweathermap.org/data/2.5/weather?lat=28.4089&lon=77.3178&appid=0bed2b0a1518636e12979616ffd459ab"
    
    // MARK: Using async await
    func downloadData1() async {
        do{
            let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                return
            }
            print(data)
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            DispatchQueue.main.async {
                self.weatherResponse = decodedData
            }
            
        }catch{
            print("Error \(error.localizedDescription)")
        }
    }
    
    // MARK: Using escaping
    func getWeatherResponse(){
        
        downloadData2(fromURL: URL(string: url)!) { data in
            if let data = data {
                guard let decodedData = try? JSONDecoder().decode(WeatherResponse.self, from: data) else{
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.weatherResponse = decodedData
                }
                
            }else{
                return
            }
        }
        
       
    }
    func downloadData2(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else{
                print("Error loading the data")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }
        .resume()
    }
    
    // MARK: Using Combine
    
    func downloadData3(){
        URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)    
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .sink { (completion) in
            
                print("COMPLETION: \(completion)")
            } receiveValue: { returnedResponse in
                self.weatherResponse = returnedResponse
            }
            .store(in: &cancellables)
    }

    
}

struct DownloadDataFromNet: View {
    @StateObject private var vm: DownloadDataFromNetViewModel = DownloadDataFromNetViewModel()
    var body: some View {
        ZStack{
//            Color.gray.opacity(0.3)
            if let weather = vm.weatherResponse {
                VStack{
                    Text("Latitude: \(weather.coordinate.latitude)")
                    Text("Longitude: \(weather.coordinate.longitude)")
                    Text(weather.weather.first!.description)
                }
            }
        }
        .task {
            
//            await vm.downloadData1()
//            vm.getWeatherResponse()
            vm.downloadData3()
        }
    }
}

#Preview {
    DownloadDataFromNet()
}
