//
//  13_SortFilterMap.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 02/09/24.
//

import SwiftUI

struct UserModel : Identifiable{
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject{
    
    @Published var dataArray: [UserModel] =  []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init(){
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers(){
        let user1 = UserModel(name: "Alice", points: 45, isVerified: true)
        let user2 = UserModel(name: "Bob", points: 78, isVerified: false)
        let user3 = UserModel(name: "Charlie", points: 23, isVerified: true)
        let user4 = UserModel(name: "Daisy", points: 96, isVerified: false)
        let user5 = UserModel(name: "Ethan", points: 12, isVerified: true)
        let user6 = UserModel(name: "Fiona", points: 57, isVerified: false)
        let user7 = UserModel(name: "George", points: 88, isVerified: true)
        let user8 = UserModel(name: "Hannah", points: 34, isVerified: false)
        let user9 = UserModel(name: "Ian", points: 65, isVerified: true)
        let user10 = UserModel(name: "Jack", points: 29, isVerified: false)
        
        self.dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10,
        ])

    }
    
    func updateFilteredArray(){
      
        
        // MARK: Sort
        /*
        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
            return user1.points > user2.points
        }
        */
        // OR we can write the same thing using $0 and $1
//        filteredArray = dataArray.sorted(by: {$0.points > $1.points})
        
         // MARK: Filter
        
        /* M1 to write the filter thing
        filteredArray = dataArray.filter({ (user) -> Bool in
            return user.isVerified
        })
        */
         
        // M2: Write filter
//        filteredArray = dataArray.filter({$0.isVerified})
        
        // MARK: Map
        /*
        // Convert the normal UserModel array to mapped Array of string
        mappedArray = dataArray.map({ (user) -> String in
            return user.name
        })
        // Or do like the below way
//        mappedArray = dataArray.map({$0.name})
        
        // Now suppose there is a case when the user is NIL in the array, then the above function would throw error, so you could prove a defaiult value using the above method... OR the other method being use compact map which deals with optionals, so basically it will skip the name in the list
        
         */
        
        // MARK: Complex filtering
        // Return the name of the users with highest point and should be verified
        mappedArray = dataArray
                         .sorted(by: { $0.points > $1.points})
            .filter({$0.isVerified})
            .map({$0.name})
        
    }
    
}

struct _3_SortFilterMap: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        /*
        //Uncomment below code for Sort and Filter
        ScrollView{
            VStack(spacing:10){
                ForEach(vm.filteredArray){ user in
                    VStack(alignment:.leading){
                        Text(user.name)
                            .font(.headline)
                        HStack{
                            Text("Points: \(user.points)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.blue.cornerRadius(10))
                    .padding(.horizontal)
                }
            }
        }
        */
        
        ScrollView{
            VStack{
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    _3_SortFilterMap()
}
