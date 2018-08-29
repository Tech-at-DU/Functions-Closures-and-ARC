/*:
 # Shorthand Closures
 So, closures can help us reduce code and store blocks of code to be executed later. But, the same closures we've been writing can be written using Type Inferance. Let's see how that looks like:
 
 We have a function that takes in the following closure as one of its parameters: `(Int) -> ()` where the int represents the place in the guest list the new guest is in.
 
 This add function is identical to the pervious lesson. But, let's see how things look simpiler
 */

let eric = Person(name: "Eric", age: 19)
var listOfGuests: [Person] = []

func add(newGuest: Person, specialRequest: (Int) -> ()) {
    listOfGuests.append(newGuest)
    
    let numberOfGuests = listOfGuests.count
    specialRequest(numberOfGuests)
}

/*:
 ## Closure trailing syntax
 if a closure is the last agrument of a function, closure trailing syntax allows you to close the function parameter list by adding the closing parathesy before the closure.
 */

add(newGuest: eric) { (guestNumber: Int) in
    print("There are \(guestNumber - 1) guests ahead of me")
    print("play rock music")
}

/*:
 ## Remove data types from params and return keyword
 In the parameter list of our closure, we can infer the type of each argument, thus we only need to define the names of each parameter and not include each type
 */

add(newGuest: eric) { guestNumber in
    print("There are \(guestNumber - 1) guests ahead of me")
    print("play rock music")
}

/*:
 ## Remove the name of the param by using $0
 We can remove the names of each parameter of the closure with $0 and use that throughout the body of the closure. $0 is the first parameter of the closure's parameter list, while $1 is the second parameter, and so on.
 */

add(newGuest: eric) {
    print("There are \($0 - 1) guests ahead of me")
}

/*:
 ## Write closure in a single line of code
 The best part is now you can write the body of the closure all on the same line of code!
 
 - note: If your closure returns a value, it too can be removed and inferred
 */

add(newGuest: eric) { print("There are \($0 - 1) guests ahead of me") }

/*:
 ## Give it a try!
 Rewrite your sorting closure to be a single line of code
 */


//copy and paste your sorting closure here


//and rewrite it to be a single line of code



//: [Previous](@previous) | [Next](@next)





























import Foundation


struct Person: CustomDebugStringConvertible {
    var name: String
    var age: Int
    
    var debugDescription: String {
        return name
    }
}
