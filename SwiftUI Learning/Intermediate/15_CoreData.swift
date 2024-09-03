//
//  15_CoreData.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 03/09/24.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject{
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core data \(error)")
            }else{
                print("Successfully loaded core data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits(){
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do{
            savedEntities =  try container.viewContext.fetch(request)
        }catch let error{
            print("Error in fetching \(error)")
        }
    }
    
    func addFruits(text: String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        
        saveData()
    }
    
    func updateFruit(entity: FruitEntity){
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetchFruits()
        }catch let error{
            print("Error in saving \(error)")
        }
   
    }
    
}
  
struct _5_CoreData: View {
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                 TextField("Add a fruit name here...",
                           text: $textFieldText)
                 .font(.headline)
                 .padding(.leading)
                 .frame(height: 55)
                 .background(Color.gray)
                 .cornerRadius(10)
                 .padding(.horizontal)
               
                
                Button{
                    // tHe text field should not be empty
                    guard !textFieldText.isEmpty else {return}
                    vm.addFruits(text: textFieldText)
                    textFieldText = ""
                    
                }label: {
                    Text("Add")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                List{
                    ForEach(vm.savedEntities){ entity in
                        Text(entity.name ?? "no name")
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    _5_CoreData()
}
