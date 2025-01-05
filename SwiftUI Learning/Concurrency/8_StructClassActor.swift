//
//  8_StructClassActor.swift
//  SwiftUI Learning
//
//  Created by Rahul Rai on 01/01/25.
//
// Credits: Following Swiftful thinking youtube

/* SUMMARY
 1. https://www.youtube.com/watch?v=-JLenSTKEcA&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=9
 2. Refer above video articles
 
 VALUE TYPES:
 - Struct, Enum, String, Int etc
 - Stored in Stack
 - Faster
 - Thread safe !
 - When you assign or pass value type a new copy of data is created
 
 REFERENCE TYPES:
 - Class, Function, Actor
 - Stored in the Heap
 - Slower, but synchroinized
 - NOT thread safe
 - When you assign or pass reference type, a new reference to original instance will be created (pointer).
 
 ---------------------------

 STACK:
 - Stores Value types
 - Variables allocated on the stakc are stored directly to the memory, and access to this memory is very fast
 - Each thread has its own stack
 
 HEAP:
 - Stores Reference types
 - Shared across threads
 
 ---------------------------
 
 STRUCT:
 - BASED ON VALUES
 - CAN BE MUTATED
 - STORED IN THE STACK
 
 CLASS:
 - BASED ON REFRENCES (INSTANCES)
 - THESE ARE STORED IN THE HEAP!
 - CLASSES CAN INHERIT FROM OTHER CLASSES
 
 ACTORS:-
 - Same as class but THREAD SAFE
 
 ---------------------------
 
 */




/* MY NOTES:-
 1. Struct has default initializers, whereas classes dont have, we need to initilize them..
 2. In structs, we pass VALUES and in classes we pass REFERENCES...
 3. Cup example for PASS BY VALUE and PASS BY REFERENCE: Suppose there are 2 cups, if you PASS BY REFERENCE, Then if you fill up the 2nd cup with coffee, the first cup will be filled with coffee too... In this case, a REFERENCE is created..
    Now if you PASS BY VALUE, then objectB that is 2nd Cup, if you fill it then only the 2nd cup gets filled and the 1st one is empty only.. Basically, A copy of cup is created in this case...
 4. Well if we see the above example, PASS BY REFERENCE makes more sense but but Passing by reference means carrying overhead of all the references and keeping all of those references in sync at all possible time whereas PASS BY VALUE makes it convenient since another copy of object does not need to worry about 1st one... Basically PASSING BY VALUE is way way FASTER then PASS BY REFERENCE.. PASS BY VALUE, that is STRUCTS are more performant too
 5. VALUE TYPE: Struct, Enum, Tuple, struct, String, struct Array(Set, Dictionary)
    Reference Type: Class, Function
 6. VALUE TYPE:- When you assign or pass value type a new copy of data is created. The copy on write - COW mechanism is used for some specific classes(like Collections(Array, Dictionary, Set))[About] with some optimisations, for example the copy is created when object is modified. For custom types you should support COW by yourself
    When you modify an instance it has only local effect.
    If Value is a local variable Stack Memory is used.
 7. REFERENCE TYPE:- ARC is used. When you assign or pass reference type a new reference to original instance will be created(the address of instance is copied).
    When you modify an instance it has a global effect because the instance is shared and accessible by any reference that points on it.
    Usually The Heap Memory is used
8. In reference type, the pointer is reference to an object which is present in the HEAP memmory. This mechanism allows sharing objects in the heap by copyying the value of their references(pointers).
 9. In value type, the integers ,structs etc, here the value based objects are stored in STACK.
 10. https://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
 11. Structs are preferable if they are relatively small and copiable because copying is way safer than having multiple references to the same instance as happens with classes.This is especially important when passing around a variable to many classes and/or in a multithreaded environment. If you can always send a copy of your variable to other places, you never have to worry about that other place changing the value of your variable underneath you.
 12. With Structs, there is much less need to worry about memory leaks or multiple threads racing to access/modify a single instance of a variable.
 13. Classes can also become bloated because a class can only inherit from a single superclass. That encourages us to create huge superclasses that encompass many different abilities that are only loosely related.
 14. https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
 15. IN 14th point, In multithreaded environment, where each thread can have its own Stack, then accessing the stack is super fast... The reason is the stack does not have to be synchronized across various threads.
 16. 1 HEAP for all threads, so synchrozination is necessary, why so?? Well suppose there are 2 threads, one of them is trying to modify the HEAP, suppose the other one also tries to modify that heap, then before that the heap should synchronize about what happened among all the threads.. Therefore SYNCHRONIZATION is necessary. Therefore it is slow. REFERE IMAGE OF MULTI THREADED..
 17. CRUX OF POINT 16 - Each thread has its own stack, No synchroinzation, its fast
        17.1. Every thread has a common HEAP, so accessing it requies SYNCHRONIZATION, therefore slower....
        17.2. Therfore, object in stack, that is value type wale objects tend to be faster wherewas classes which are stored in heap is slower.
 */


/* MY NOTES ON ARC
 1. https://medium.com/doyeona/automatic-reference-counting-in-swift-arc-weak-strong-unowned-925f802c1b99
 2. In point 1 about ARC, CPU is not managing heap memory (reference type such as class) automatically and that’s what ARC exists for to prevent memory leak.
 3. [IMP] value types which store on stack memory such as structures and enumerations are just copying the data to data. therefore it’s not affected by ARC.
 4. Automatic Reference Counting (ARC) is to track and manage the app’s memory usage. ARC automatically frees up the memory used by class instances when those instances are no longer needed.
 5. Every time creating a new class instance, ARC allocates a chunk of memory to store information about that instance and when it’s no longer needed, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead.
 6. Every instance of a class has a property called reference count so if reference count is greater than 0, the instance is still kept in memory otherwise, it will be removed from the memory.
 */

/* MY NOTES ON ACTORS
 1. Actors are same thing as classes but they are thread safe.
 2. Classes can have race condition, suppose if 2 threads are there and both of them try to modify the same object in class, that coudl lead to race conditions
 3. If two threads are accessing same actor, then one of the thread need to await, so that the 2nd one could work...
 */

/* MY NOTES ON WEAK SELF
 /*
  func downloadImageWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
      URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
          let image = self?.handleResponse(data: data, response: response)
          completionHandler(image, error)
      }
      .resume()
  }
  */
 1. In the above code, we are using [weak self] to avoid retain cycle.
 2. The closure will not execute immediately, its asynchronous.
 3. There is going to be a delay when the function is going to fetch the data and whrn the closure is being executed.
 4. Why [WEAK self],
 
 
 */

import SwiftUI

struct __StructClassActor: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear{
                runTest()
            }
    }
}

#Preview {
    __StructClassActor()
}






extension __StructClassActor {
    private func runTest(){
        print("TEST STARTED")
//        structTest1()
//        printDivider()
//        classTest1()
//        printDivider()
        structTest2()
        printDivider()
        classTest2()
        printDivider()
        actorTest1()
    }
    
    private func printDivider(){
        print("""
        
        - - - - - - - - - - - - - - - - - - - - - -

        """)
    }
    
    // STRUCT TEST
    private func structTest1(){
        print("structTest1")
        let objectA = MyStruct(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        print("Pass the VALUES of objectA to objectB.")
        var objectB = objectA
        print("ObjectB: ", objectB.title)
        
        /*
         //  Initial Config:- struct MyStruct has let title: String and in structTest1(), we have let objectB = objectA...
         //  We need to change both of them to var in order to change the title inside objectB.
         //  The reason we need to make objectB a variable is because when we are changing the title inside objectB, we are actually changing/ mutating the whole struct.. To mutate the struct means more or less recreating an entire struct again...
         // NOTE:- Its not the case that we are moving into objectB then changing the title only, though it looks like that but we are recreating the whole struct...
         // Basically the VALUE of objectA is being passed to objectB and a new struct is created overall.
         */
        
        objectB.title = "Second Title"
        print("ObjectB title changed.")
        
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    // CLASS TEST
    private func classTest1(){
        print("classTest1")
        let objectA = MyClass(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        print("Pass the REFERENCE of objectA to objectB.")
        let objectB = objectA
        print("ObjectB: ", objectB.title)
        
        /*
         // NOTE: Here compiler is not throwing us error, though we have objectB as let.. The reason being here we are changing the title of the objectB and not the whole object itself..
            
         */
        
        objectB.title = "Second Title"
        print("ObjectB title changed.")
        
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    // Actor test 1
    private func actorTest1(){
        Task{
            print("actorTest1")
            let objectA = MyActor(title: "Starting title!")
            await print("ObjectA: ", objectA.title)
            
            print("Pass the REFERENCE of objectA to objectB.")
            let objectB = objectA
            await print("ObjectB: ", objectB.title)
            
            /*
             // NOTE: Here compiler is not throwing us error, though we have objectB as let.. The reason being here we are changing the title of the objectB and not the whole object itself..
                
             */
            
            await objectB.updateTitle(newTitle: "Second Title")
//            objectB.title = "Second Title"
            print("ObjectB title changed.")
            
            await print("ObjectA: ", objectA.title)
            await print("ObjectB: ", objectB.title)
        }

    }

}

// MARK: - STRUCT - TESTS

// Struct
struct MyStruct {
    
    var title: String
}


// IMMUTABLE STRUCT
struct CustomStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        CustomStruct(title: newTitle)
    }
    
}

struct MutatingStruct {
    private(set) var title: String  // We want to set it only from inside the struct whereas get anywhere in the code...
    
    init(title: String) {
        self.title = title
    }
    
    // Why mutating? CHANGING TITLE leads to change in entire object
    mutating func updateTitle(newTitle: String){
        title = newTitle
    }
}


extension __StructClassActor {
    private func structTest2(){
        print("structTest2")
        
        var struct1 = MyStruct(title: "Title1")
        print("Struct1: ", struct1.title)
        struct1.title = "Title2"
        print("Struct1: ", struct1.title)
        
        // How to change title in Immutable Struct
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2: ", struct2.title)
        struct2 = CustomStruct(title: "Title2")
        print("Struct1: ", struct2.title)
        
        // Another way to change title in Immutable Struct...
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3: ", struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title2")
        print("Struct3: ", struct3.title)
        
        
        // Difference in previous struct3 and struct 4.. Previous struct3 updates and returns back a new struct. But the struct4, do the changes in place
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4: ", struct4.title)
        struct4.updateTitle(newTitle: "Title2")
        print("Struct4: ", struct4.title)
    }
}


// MARK: - CLASS STRUCT

// CLASS
class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String){
        title = newTitle
    }
    
}

extension __StructClassActor {
    private func classTest2(){
        print("classTest2")
        
        let class1 = MyClass(title: "Title1")
        print("Class1: ", class1.title)
        class1.title = "Title2"
        print("Class1: ", class1.title)
        
        // How to update title? Similar to way we did in mutatingu
        let class2 = MyClass(title: "Title1")
        print("Class2: ", class2.title)
        class2.updateTitle(newTitle: "Title2")
        print("Class2: ", class2.title)
    }

    
}


// ACTOR

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String){
        title = newTitle
    }
    
}
