// Referred: https://youtu.be/XAlXnApplk0?si=HlNTkzYlRfFaZ1aA

import SwiftUI

// ARC - Swift internally decides if an object of a class is made and its not used again after that, it remove it from its memory, its handled through ARC...

// WHY ARC IS IMPORTANT?
// We know phones have limited memory, so if we tend to create so many strong reference cycle then there will not be any free memory and the phone will start to hang, since the memory gets blocked... therefore ARC is important...

class Person {
    var name: String
    
    init(name: String) {
        print("Init method of person class called")
        self.name = name
    }
    
    func printName(){
        print("Name is \(name)")
    }
    
    // Performs cleanup before object is deallocated...
    deinit{
        print("Deinit method of person class called")
    }
    
}

// TRICKING SWIFT COMPILER, TO TELL THE OBJPERSON HAS USE TILL PRINTNAME ONLY...
if (1 == 1){
    let objPerson = Person(name: "Rahul")
    objPerson.printName()
}

var objPerson1: Person?
var objPerson2: Person?

// Will deinit be called in below example?
if (2 == 2){
    let objPer = Person(name: "Mike")
    objPerson1 = objPer
    objPerson2 = objPer
    objPer.printName()
}
// No, it wont be called if we run our code to this point, because the compiler will think objPerson is still being in use because of objPerson1 and objPerson2, which holds reference to it...

// So we need to explcitly make it nil
objPerson1 = nil
objPerson2 = nil


// 3rd Example: Demonstrating a strong reference...
class Person1 {
    var name: String
//    var job: Job?
    weak var job: Job?
    
    init(name: String) {
        print("Init method of person class called")
        self.name = name
    }
    
    func printName(){
        print("Name is \(name)")
    }
    
    // Performs cleanup before object is deallocated...
    deinit{
        print("Deinit method of person class called")
    }
    
}

class Job {
    var jobDescription: String
    var person: Person1?
    
    init(jobDescription: String) {
        print("Init method of person class called")
        self.jobDescription = jobDescription
    }
    
    func printJob(){
        print("Job is \(jobDescription)")
    }
    
    // Performs cleanup before object is deallocated...
    deinit{
        print("Deinit method of person class called")
    }
    
}
// NOTE: OUR CODE DICTATES HOW ARC WILL WORK, IN BELOW CASE CREATING A STRONG REFERENCE CYCLE TENDS TO MAKE PROBLEMS SINCE ARC WILL NEVER GET IT 0... SO WE SHOULD USE WEAK WHILE DEFINING THE PROPERTIES TO TELL THE COMPILER TO NOT HOLD STRONG REFERENCES..

// Strong reference cycle: First object referring to 2nd object and 2nd objet referring to first...
if(3 == 3){
    let objPerson3 = Person1(name: "Rahul")
    let objJob3 = Job(jobDescription: "SDE")
    objPerson3.job = objJob3
    objJob3.person = objPerson3
}

// Other way to break the strong reference cycle is to set the object relationship to nil...
// objPerson3.job = nil -> This will break the strong reference cycle...


