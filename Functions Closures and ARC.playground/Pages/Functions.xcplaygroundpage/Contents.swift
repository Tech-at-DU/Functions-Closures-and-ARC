
/*:
 ![Make School Banner](./swift_banner.png)
 # Functions
 
 TODO: intro
 
 ## Function Atanomy
 ![function atanomy](./function.png)
 
 1. `func` is how you declare a new function/method
 1. functionName is the name of this function (use calmel case when naming your functions)
 1. Inside the parenthises is the parameter list. First, is the name of the parameter (this will be the variable name you'll use in the function). Then, the data type after a colennn `:`. Each parameter is separated by a comma.
 1. Lastly, the return type. If your function doesn not return a value, then leave out the `-> ReturnType`
 
 Here are more examples:
 */

//function that takes in an int and returns a string of that int
func convertNumberIntoString(number: Int) -> String {
    let stringFromNumber = String(number)
    
    return stringFromNumber
}

//function that takes in an array of numbers and prints each number
func printTheListOfNumbers(numbers: [Int]) {
    for aNumber in numbers {
        print(aNumber)
    }
}

//this function takes in no arguments and does not return a value
func printTheCurrentTime() {
    let now = Date()
    
    print(now)
}

/*:
 ## Calling a function/method
 
 Using the same functions from above, here's how we call them:
 */

let numberFive = 5
let stringFromANumber = convertNumberIntoString(number: numberFive)
print(stringFromANumber)


let numbersToPrint = [2, 56, 7, 8, 43, 2]
printTheListOfNumbers(numbers: numbersToPrint)


printTheCurrentTime()

/*:
 ## More examples with functions
 
 Say you have a guest list who are attending your event. Lets use the following `Guest struct` to create our guest list. This Guest struct has two properties name and age.
 
 - note: Guets conforms to two protocols `CustomDebugStringConvertible`, `Equatable`. Protocols will be described in a later lesson.
 - This struct also has a computed var `debugDescription` which is used to print nicely in print statements. `debugDescription` is part of `CustomDebugStringConvertible` protocol.
 
 - As for `Equatable`, this allows our struct to be compared with another instance of the same struct using the `==` operator.
 */

struct Guest: CustomDebugStringConvertible, Equatable {
    var name: String
    var age: Int
    
    var debugDescription: String {
        return name
    }
}

/*:
 We'll start with a single guest.
 
 Write a function that prints the name and age of a person
 1. give the function a proper name
 1. add one parameter to the function's parameter list and give the parameter a name and the correct data type (we want to pass into the function the eric variable which is a Guest type)
 1. In the body of this function, use a print statement to print the argument's name and age properties
 1. Once you've writen the function, call it and pass the variable eric into the function. It should print: `Eric, 19` in the console.
 
 ![console](./console-1.png)
 */

let eric = Guest(name: "Eric", age: 19)

//write the function here


//call the function and pass in eric into the function


/*:
 Lets invite more guests and store the guests into an array.
 
 1. Now, with the array of guests, write a function that takes in an array of guests and prints each guest in that array (hint: the parameter's type will look like this `[Guest]`)
 1. In the body of the function, use a for loop to print each guest
 */

let sam = Guest(name: "Sam", age: 24)
let sara = Guest(name: "Sara", age: 23)
let charlie = Guest(name: "Charlie", age: 18)
let invitedGuests = [sam, eric, sara, charlie]

//write the funciton here


//call the function and pass in invitedGuests into the function


/*:
 Great! Now that we have our list of invited guests we can see each of their age. Since we'll be having guests ranging from teens to adults, we need to see who's 18 years or older.
 
 Write a function that returns a list of guests who are 18 years or older
 1. give the function a proper name
 1. add one argument that takes in an array of guests
 1. set the return type of this function to be an array of guests `-> [Guest]`
 1. in the body of the function, loop through each guest in the given array of guests and check if each age is greater than or equal to 18. If so, add the guest to a new array
 1. after the for loop, return the new array of guests that contain guests that are 18 years or older
 */

//write the function here


//call the function and use this list of guests as your input to your function
invitedGuests


/*:
 ## Internal and external names
 
 In Swift, each parameter variable name in a function parameter list can have two names; internal and external names. The internal name is the variable name used inside the body of the function while the external name is what is used when the function is being called or used.
 
 ![function external names](./function-external-names.png)
 
 - note: If a parameter only has one name, it's used for both the external and internal names for that parameter.
 
 Here are some examples:
 */

//this functions returns true or false if the given guest list contains the given guest
func does(_ guestList: [Guest], contain guest: Guest) -> Bool {
    if guestList.contains(guest) {
        return true
    } else {
        return false
    }
}

/*:
 
 * This function has two parameters in its parameter list. The first parameter has an external name of `_` which is a way to say there is no external name. But, the internal name is `guestList`.
 * As for the second parameter, the external name is `contain` and the internal name is `guest`.
 
 Lets see how the function looks like when it's called:
 */

let isEricAlreadyInvited = does(invitedGuests, contain: eric)
print(isEricAlreadyInvited)

/*:
 ## Instance and class methods
 
 Lastly about functions are adding functions inside a class or struct. Swift also supports functions inside of enums.
 
 ### Instance methods
 
 You are now a bank owner! Congrats! But, we need a class for our customers. So, lets create a new class!
 
 And, here it is:
 */

class Customer: CustomDebugStringConvertible {
    
    //1
    private static var numberOfCustomers = 0
    
    //2
    var firstName: String
    var lastName: String
    var age: Int
    
    //3
    var debugDescription: String {
        return getFullName()
    }
    
    //4
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
        Customer.numberOfCustomers += 1
    }
    
    //5
    deinit {
        Customer.numberOfCustomers -= 1
    }
    
    //6
    static func getNumberOfCustomers() -> Int {
        return numberOfCustomers
    }
    
    //7
    func getFullName() -> String {
        return firstName + " " + lastName
    }
}

/*:
 Lets talk about what our new class has
 1. This is a class property that will serve as a counter of how many customers we have in total. In step 6 we'll see how to use a class property/method
 - note: This class property also has a `private` as its control flow. Long story short, this property is ONLY visible inside the class itself, thus if you use try to read or change this class property, the complier will not like this:
 ![private properties](./control-flow-1.png)
 2. These are instance properties, thus these peorpties are only accessable from an instance of our Customer class:
 ![instance properties](./isntance-properties.png)
 1. As used in our `Guest` struct, this property is part of the `CustomDebugStringConvertible` protocol. Here we return the value of an instance method `getFullName() -> String`
 1. This is our initializer, or constructor, for our class. Since we need to update the number of customers, here is the best place to increament that count.
 1. This is the opposite of an initalizer. This block of code is executed when an instance of our class is being deleted from memory. More on memory management in a later lesson. Here, we'll decrement the customer counter
 1. Since our class property counter is private, we created a static method that returns the value of that class property. This is how we prevent any code of changing the value of the customer counter.
 1. This is our instance method that returns the first and last name values into a single string separated by a space.
 
 Lets create some customers and print the number of customers
 1. print the number of customers in a print statement using the class method `getNumberOfCustomers()`
 */

let sammy = Customer(firstName: "Sammy", lastName: "Love", age: 19)
let dan = Customer(firstName: "Dan", lastName: "Rodgrize", age: 20)
let timmy = Customer(firstName: "Timmy", lastName: "Turnner", age: 18)

//print the number of customers here


//: [Previous](@previous) | [Next](@next)


















import Foundation
