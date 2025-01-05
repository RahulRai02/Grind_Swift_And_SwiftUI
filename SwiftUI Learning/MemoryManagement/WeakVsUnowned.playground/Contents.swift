// MARK: - WEAK VS UNOWNED...

/*
 REFERENCE TYPES
 1. weak class delegate protocol
 2. weak closures
 3. weak class property
 
 - Strong references are created only with reference types not value types.
 - To break Strong references we used weak keyword...
 - We have one more keyword which helps us to avoid strong reference - UNOWNED...
 
 */

/*
 - WEAK:
    - Both are used to break strong reference cycles.
    - Use weak only if, in an object relationship, one object can be nil. Ex: In Employee class, if the project can be nil, then use weak since its not necessary that every employee should have a project at some point of time...
    - Rules to use weak:
        1. It should be always use with mutable types: Like use with a var...
        NOTE: DONT USE A LET, BECAUSE THE Property coudl change at run time...
        class Employee {
            weak var project: Project? = nil
        }
        2. It should be always be optional...
        
 - UNOWNED:
    - Use unowned only if, in an object relationship, one object can never be nil. Suppose there is a BankAccount class and it has a property person, then its neceessary that every bank account should have a person, so we use unowned... Here Person cant be nil
        Ex: class BankAccount {
                unowned var person: Person
            }
    - Unowned coudl also be used with optional unowned var person: Person?
    - Unlike a weak reference, an unowned reference is expected to always have a value. As a result, marking a value as unowned doesn't make it optional, and ARC never sets an unowned reference's value to nil.
 
 */
