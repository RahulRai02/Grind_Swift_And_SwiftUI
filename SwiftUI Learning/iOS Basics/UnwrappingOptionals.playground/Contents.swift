import SwiftUI


/*
  ? -> Optional: This "? " means that the variable can have a value or can be nil.
 
 */


struct User {
    let name: String
    let age: Int?   // Here age is optional, it can have a value or can be nil
}



let user = User(name: "Rahul", age: 25)

let user1 = User(name: "Mike", age: nil)

// Unwrapping Optional ways:-
/*
    1. If let
    2. Guard let
    3. Nil Coalescing Operator
    4. Optional Chaining
    5. Force Unwrapping
 
 */

// MARK: - 1. IF LET:
// Cons: Pyramid of doom could be created since the upwrapped age has scope only inside the if let block
if let age = user.age {
    print("Age is \(age)")
}else{
    print("User did not enter any age..")
}


// Pyramid of doom could be prevented...
// MARK: - 2. GUARD LET:
// EARLY EXIT: If the condition is not met, it will exit the function
func checkAge(age: Int?){
    guard let age = age else {
        print("Age is nil")
        return
    }
    
    if age > 18 {
        print("You are eligible to vote")
    }
}

checkAge(age: nil)
checkAge(age: 25)
checkAge(age: 15)


// MARK: - 3. NIL COALESCING OPERATOR
// Provides a default value when the optional is nil

let userAge = user1.age ?? 18
print("User age is \(userAge)")


// MARK: - 4. Force Unwrapping
// Will lead to crash if the value is nil: Unexpectedly found nil while unwrapping an Optional value
//let userAge1 = user1.age!
let userAge1 = user.age!
print("User age is \(userAge1)")


// MARK: - 5. Optional Chaining
// This is when the entire object is optional

// Made this struct to explain optional chaining...
struct User2 {
    let name: String
    let age: Int
}

var optionalUser: User2?
let name = optionalUser?.name ?? "No Name"  // Here optionalUser is an optional...

if let newName = optionalUser?.name {
    print("Name is \(newName)")
}
