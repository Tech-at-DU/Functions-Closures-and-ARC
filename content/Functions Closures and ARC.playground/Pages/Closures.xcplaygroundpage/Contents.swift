
/*:
 # Closures
 
 Closures, or nameless functions, are consided a first-class citizen in Swift. Meaning, a closure looks no different compared to a String in Swift.
 
 With that said, you can use closures as a property of a class or a parameter in a function. You can also assign closures to variables to be used at a later point in time.
 
 We'll be using our `Guest struct` from the previous tutorial. As a refresher, here's the struct:
 */
struct Guest: CustomDebugStringConvertible, Equatable {
    var name: String
    var age: Int
    
    var debugDescription: String {
        return name
    }
}
/*:
 ## The Similarities a Closure has with a Function
 
 Lets look at a function and see how it looks like if we wrote it as a closure:
 */

let eric = Guest(name: "Eric", age: 19)

//this function has one parameter and is of type Guest
func printGuestInfo(guest: Guest) {
    print("Name: \(guest.name)", "Age: \(guest.age)")
}

printGuestInfo(guest: eric)

/*:
 
 Now for a closure, let first look at how a function is constructed:
 
 ![function structure](./function-structure.png)
 
 And here's a closure's structure:
 
 ![closure structure](./closure-structure.png)
 
 Although they're very similar, there are a few key differences:
 - The closure lacks the `func` keyword
 - The closure does not require a function name
 - The parameter list and return type are in front of the `{`
 - The return type and the body of the closure are separated by the `in` keyword
 
 Now lets write a closure and assign it to a variable
 */

let blockOfCodeToPrintGuestInfo = { (guest: Guest) in
    print("Name: \(guest.name)", "Age: \(guest.age)")
}

/*:
 Any guesses on how we'd execute the closure?
 
 If we were to hit play on this playground, the print statement inside the body of our closure is never executed, it's only contained inside the `blockOfCodeToPrintGuestInfo` variable.
 
 1. try to execute the closure to print the guest info of sam
 */

let sam = Guest(name: "Sam", age: 17)

blockOfCodeToPrintGuestInfo(sam)













/*:
 If you want to compare your answer, look here:
 ```
 let sam = Guest(name: "Sam", age: 17)
 
 blockOfCodeToPrintGuestInfo(sam)
 ```
 
 ## More Examples
 Here are some variables that contain different kind of closures:
 */

//closure with no params and no return type
var blockOfCode1: () -> () = {
    
}

//closure with two params and no return type
var blockOfCode2: (String, Int) -> () = { param1, param2 in
    
    //param1 is a string
    print(param1)
    
    //param2 is an int
    print(param2)
    
}

//closure with two params and int as the return type
var blockOfCode3: (Int, Int) -> Int = { param1, param2 in
    return param1 * param2
}

//this closure is used to validate if the given string contains only numbers
let numbersOnlyValidator: (String) -> Bool = { (stringValue: String) in
    for aCharacter in stringValue {
        let aSingleString = String(aCharacter)
        
        //explain why this checks if a string contains a non-digit string value
        if Int(aSingleString) == nil {
            return false
        }
    }
    
    return true
}

/*:
 Let's see how we execute each closure:
 */

//no params to execute this closure
blockOfCode1()


//two params to execute this closure
blockOfCode2("This is a string", 99)


//two params to execute this closure and this closure returns an int
let returnValueFromClosure = blockOfCode3(9, 9)


//test if userInput contains only numbers
let userInput = "Twenty"

if numbersOnlyValidator(userInput) {
    print("input from user was valid")
} else {
    print("input from user was invalid")
}

/*:
 -------------------INSTRUCTOR NOTE-------------------
 
 Below section is confusing, as specialRequest does not do anything. Contact student who wrote this section to understand their intent, or remove section.
 
 -------------------INSTRUCTOR NOTE-------------------
 */

/*:
 Closures are primarily used for two things:
 1. **A container of code used as a utility**, like a validator, or a set a rules to sort by.
 1. **A container of code to be executed later**, perhaps after a task is finished (like a network call is finished downloading a list of users from the internet).
 
 ## Closures used as parameters of a function
 
 Let's go back to our extravagent event we were previously planning. We need to easily be able to add guests to our guest list, but we also want to be aware of any special requests they may have (you know how Dory only eats those rare olives from Spain).
 
 Let's write a function that adds a new guest to our list of guests, and also asks the guest if they have any special request they'd like us to execute.
 
 This closure has a parameter of one integer. This integer represents the number of guests when the new guest was added.
 */

var listOfGuests: [Guest] = []

func add(newGuest: Guest, specialRequest: (Int) -> ()) {
    
    //add the new guest to the guest list
    listOfGuests.append(newGuest)
    
    //get the count of the guest list
    let numberOfGuests = listOfGuests.count
    
    //execute the special request and pass the number of guests into the closure
    specialRequest(numberOfGuests)
}

/*:
 Now, use this new add guest function to add sara to the guest list. Her special request is a print statement that says "Turn up the music!"
 */

let sara = Guest(name: "Sara", age: 23)

//invite sara by using add(..) function here

/*:
 We've now got a solid understanding of what closures are. Let's move on to the next section to learn more on how to use them:
 */
//: [Previous](@previous) | [Next](@next)
























import Foundation

