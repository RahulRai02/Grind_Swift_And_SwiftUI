//
//  12_HashableProtocol.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 01/09/24.
//

// Hashable mainly used when iterating over items of a model so we need to give ids to each and every item uniquely
// So if we confirm it to hashable then it assigns an unqiue id to the item.. We can also confirm to Identifiable

//The main difference between Identifiable and Hashable is that conforming to Identifiable only says that your model has some unique identifier (which may be different every time you create an instance even with the same member values) whereas Hashable is a guarantee that an instance of your model will always produce the same hash value for a given set of member values. The latter is important because it allows you to use your model as the key in a dictionary as well as in SwiftUI view builders such as ForEach.



import SwiftUI

//struct MyCustomModel : Identifiable{
//    let id = UUID().uuidString
//    let title: String
//}


// SUppose we dont want a seprate id field in our model, just confirm it to Hashable
struct MyCustomModel : Hashable{
//    let id = UUID().uuidString
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
}




struct _2_HashableProtocol: View {
    
//    let data: [String] = [ "ONE", "TWO", "THREE", "FOUR", "FIVE",]
    // By default String conforms to Hashable protocol, so if we do \.self as id, it will assing a unique hash value to the item present in the array. The hash value can be accessed by doing item.hashValue.description

    // Lets now make our data using the model
    let data : [MyCustomModel] = [
    MyCustomModel(title: "ONE"),
    MyCustomModel(title: "TWO"),
    MyCustomModel(title: "THREE"),
    MyCustomModel(title: "FOUR"),
    MyCustomModel(title: "FIVE"),
    
    ]
    
    var body: some View {
        // data is just string
//    ScrollView{
//            VStack(spacing: 40){
//                ForEach(data, id: \.self) { item in
//                    Text(item)
//                        .font(.headline)
//                }
//            }
//        }
        // Using Identifiable
//        ScrollView{
//            VStack(spacing: 40){
//                ForEach(data) { item in
//                    Text(item.title)
//                        .font(.headline)
//                }
//            }
//        }
        
        // Using Hashable
        ScrollView{
                VStack(spacing: 40){
                    ForEach(data, id: \.self) { item in
                        Text(item.title)
                            .font(.headline)
                    }
                }
            }
    }
}

#Preview {
    _2_HashableProtocol()
}
