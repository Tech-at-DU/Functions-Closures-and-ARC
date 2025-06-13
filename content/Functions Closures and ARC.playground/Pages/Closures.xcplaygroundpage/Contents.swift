
/*:
 # Closures

 Closures, are anonymous functions, that is functions without names.

 You can use closures as a property of a class, a parameter in a function, or assign them to a variable. Think of closures are blocks of code you can include anywhere you might have a variable.

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

 */

let eric = Guest(name: "Eric", age: 19)

//this function has one parameter and is of type Guest
func printGuestInfo(guest: Guest) {
    print("Name: \(guest.name)", "Age: \(guest.age)")
}

printGuestInfo(guest: eric)

/*:
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
 ## Closure Syntax
 
 In Swift closures have a range of alternative syntaxes, that you can use to simplify how they are written.
 */

// closure with no params and no return type
var blockOfCode1: () -> () = {
  print("Testing Block 1")
}

// var name: funcType = { func block }

// closure with two params and no return type
var blockOfCode2: (String, Int) -> () = { param1, param2 in

    //param1 is a string
    print(param1)

    //param2 is an int
    print(param2)

}

// var name: (argTypes) -> returnType = { params in codeBlock }

//closure with two params and int as the return type
var blockOfCode3: (Int, Int) -> Int = { param1, param2 in
    return param1 * param2
}

//this closure is used to validate if the given string contains only numbers
let numbersOnlyValidator: (String) -> Bool = { (stringValue) in
    for aCharacter in stringValue {
        let aSingleString = String(aCharacter)

        if Int(aSingleString) == nil {
            return false
        }
    }

    return true
}


/*:
 Let's see how we execute each closure:
 */

// no params to execute this closure
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
 CHALLENGE!
 Write an closure that takes no arguments/parameters. Assign it to the variable `testClosure1`. Call `testClosure1` to test it.
 */




/*:
 CHALLENGE!
 Write an closure that takes two arguments/parameters make these type Int.
 The code block should multiply the to parameters, and return the product.
 Call the closure to test it. 
 */





/*:
 We've now got a solid understanding of what closures are. Let's move on to the next section to learn more on how to use them:
 */

//: [Previous](@previous) | [Next](@next)
























import Foundation
