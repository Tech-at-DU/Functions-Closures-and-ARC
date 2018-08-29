
/*:
 # Common Uses of Closures
 
 One of the common uses of closures are high order functions on arrays. Methods like `sort`, `filter`, `reduce` and `map` use closures.
 
 Let's look at how using some of these higher order functions and closures simplify some of our code.
 
 ## Filtering
 The filter method on an array will return a new array with elements that returned true in the given closure. The closure's signature looks like this:

 ### Signature
`(Element) -> Bool` where Element is the type of what's in the array
 
 In our case, Element is our Person struct since we have an array of Person.
 
 In our example, we'll pass a closure that returns true if the guest.age >= 18. Otherwise, return false.
 */

let eric = Person(name: "Eric", age: 19)
let sam = Person(name: "Sam", age: 17)
let sara = Person(name: "Sara", age: 23)
let charlie = Person(name: "Charlie", age: 18)

let guestList = [sam, eric, sara, charlie]

//filtering using our own function
func guestsWhoAreEighteenYearsOfAgeOrOlder(guests: [Person]) -> [Person] {
    var listOfGuestsWhoAreEighteenYearsOfAgeOrOlder: [Person] = []
    
    for aGuest in guests {
        if aGuest.age >= 18 {
            listOfGuestsWhoAreEighteenYearsOfAgeOrOlder.append(aGuest)
        }
    }
    
    return listOfGuestsWhoAreEighteenYearsOfAgeOrOlder
}

let adultsList = guestsWhoAreEighteenYearsOfAgeOrOlder(guests: guestList)

//filtering using a high order function
let adultsListFromFilter = guestList.filter { (aGuest: Person) in
    if aGuest.age >= 18 {
        return true
    } else {
        return false
    }
}

/*:
 As you can tell, the filter method is much smaller than having to create our own function. Later in this lesson you'll learn how to reduce the code down to a single line a code!
 
 Let's look at some more functions
 
 ## Sort
 This too takes a closure but the sigature of this closure is different:
 ### Signature

 `(Element, Element) -> Bool`.
 
 Sorted will compare two elements in the array and will use this closure to determin if the first element should be sorted before the second element.
 
 The Closure will return true if its first argument should be ordered before its second argument.
 - note: you can reverse this by negating the logic thus sorting by descending order vs ascending
 */

//sort by age, oldest is at the front of the array
let sortedGuestList = guestList.sorted { (aGuest: Person, bGuest: Person) in
    if aGuest.age >= bGuest.age {
        return true
    } else {
        return false
    }
}

/*:
 ## Map
 Think of the map function as a transforming function, convert an array of numbers into an array of strings, for example.
 
 ### Signature

 `(Element) -> Result` where Element is the type of the array, and Result is the new type you want to map each element into
 
 There's a bit more you have to define when using map on an array:
 1. Define what the return type is for the given closure
 1. Return a new instance of the same type as the closure's return type
 
 Let's create a list of lowercased strings and try to uppercase them (the return type of the closure can be the same type as the original array)
 */

let lowerCaseLetters = ["a", "z", "b", "x", "c", "y"]
let upperCaseLetters = lowerCaseLetters.map { (aLetter: String) -> String in
    let upperCaseOfLetter = aLetter.uppercased()
    
    return upperCaseOfLetter
}

/*:
 Another example, let's create two separate arrays. One contains the ages and the other contains only the names
 - important: notice the return type of each closure matches the return value inside the closure's body
 */

let listOfAgesFromGuests = guestList.map { (aPerson: Person) -> Int in
    return aPerson.age
}

let listOfNamesFromGuests = guestList.map { (aPerson: Person) -> String in
    return aPerson.name
}

/*:
 ## Reduce
 This one is interesting. Reduce will, like all other high order functions, iterate through each element in the array but the goal is to reduce the array to a single new type.
 
 - example: you have an array of integers and you want to reduce the array into a sum, a single integer
 
 ### Signature
 
 `(Result, Element) -> Result` where Element is the type of the array, and Result is the new type you want to reduce each element into
 
 The first argument is what the current reduced form looks like. The second argument is an element from the array.
 
 Let's try this out by writing the first example out:
 */

let randomNumbers = [2, 1, 6, 2, 8, 3, 10, -1]
let sumOfRandomNumbers = randomNumbers.reduce(0) { (sumSoFar, anInt) -> Int in
    let newSum = sumSoFar + anInt
    
    return newSum
}

/*:
 This example reduces the array of guests into a sentence, or String, that contains the names of all the guests separated by a comma
 */

let namesCombined = guestList.reduce("") { (sentence, aPerson) -> String in
    let newSentence = aPerson.name + ", " + sentence
    
    return newSentence
}

/*:
 ## You try!
 
 Practice using the high order functions by completing the following:
 */

//sort these numbers
let numbersToSort = [2, 4, 4, 2, 1, 0]


//sort the guests by name
let guestsToSort = [sam, eric, sara, charlie]


//sort the guests by age, but in descending order (youngest at the front of the array)


//filter the guests to only include guests younger than 18 years


//filter the numbers to only include event numbers
let numbersToFilter = [2, 1, 1, 5, 6, 7, 10]


//map the numbers to be double their values (e.g. 5 gets mapped to 10)
let numbersToDouble = [2, 4, 6, 8]


//map the numbers into strings
let numbersToMapIntoStrings = [2, 4, 5, 1, 2, 2]


//reduce the numbers into a sum, but exclude negative numbers from the sum. Thus, your reduce closure should reduce this array to equal 10
let numbersToSum = [-2, -5, -4, 5, -5, 5]



//: [Previous](@previous) | [Next](@next)






















struct Person: CustomDebugStringConvertible {
    var name: String
    var age: Int
    
    var debugDescription: String {
        return name
    }
}
