
/*:
 # Common Uses of Closures
 
 A common place you’ll see closures is inside higher-order array functions (often called HOFs). A higher-order function takes another function or closure as an argument and returns a new value—usually a transformed array. On Array the key HOFs are map, filter, reduce, and sorted(by:); each accepts a closure you supply and produces a new array (or single value) based on the original elements.
 
 ## Filtering
 The **filter** method on an array will **return a new array with elements that returned true in the given closure.** The closure's signature looks like this:
 
 ### Signature
 `(Element) -> Bool` where `Element` is the type of what's in the array
 
 In our case, `Element` is our Guest struct since we have an array of Guest. Here's that Guest struct as a reminder:
 */
struct Guest: CustomDebugStringConvertible, Equatable {
    var name: String
    var age: Int
    
    var debugDescription: String {
        return name
    }
}
/*:
 In our example, we'll pass a closure that returns true if the guest's age is greater than or equal to 18. Otherwise, return false.
 */

let eric = Guest(name: "Eric", age: 19)
let sam = Guest(name: "Sam", age: 17)
let sara = Guest(name: "Sara", age: 23)
let charlie = Guest(name: "Charlie", age: 18)

let guestList = [sam, eric, sara, charlie]

/*:
 Below is how we would filter without the use of HOFs and closures:
 */

// filter function using our own function
func adultGuests(guests: [Guest]) -> [Guest] {
    var adultGuestList: [Guest] = []
    
    for aGuest in guests {
        if aGuest.age >= 18 {
            adultGuestList.append(aGuest)
        }
    }
    
    return adultGuestList
}

let adultsList = adultGuests(guests: guestList)

/*:
 
 Now let's see how we can write our solution more efficiently through using HOFs and closures:
 
 */

// filtering using a HOF
let adultsListFromFilter = guestList.filter { (aGuest: Guest) in
  return aGuest.age >= 18
}


/*:
 
 ### Re-written paragraph

 ---

 #### `sorted(by:)`

 `sorted(by:)` returns **a new array whose elements are arranged according to the closure you provide**.
 The closure’s signature is:

 ```swift
 (Element, Element) -> Bool
 ```

 For every pair of elements, Swift calls your closure and expects `true` if the **first argument should come before the second** in the final order. Using the standard “ascending” comparison is usually as simple as:

 ```swift
 let ascending = numbers.sorted(by: <)   // Same as .sorted()
 ```

 Want descending order? Flip the comparison:

 ```swift
 let descending = numbers.sorted(by: >)
 ```

 > **Tip:** `sorted(by:)` is non-mutating—it leaves the original array untouched and returns a new array. If you need in-place sorting, use `sort(by:)` instead.

 */

// sort by age, oldest is at the front of the array
let sortedGuestList = guestList.sorted { (aGuest: Guest, bGuest: Guest) in
    if aGuest.age >= bGuest.age {
        return true
    } else {
        return false
    }
}

/*:
 ## `map(_:)`

 Think of **`map`** as a *transformer*: it walks through a collection, applies the closure to every element, and returns a **new** array containing each transformed value.

 ### Signature

 ```swift
 (Element) -> Result
 ```

 * **`Element`** – the type stored in the original array.
 * **`Result`** – the type you want each element converted to (often—but not necessarily—the same as `Element`).

 When you call `map` you must:

 1. Provide a closure whose return type is the `Result` you need.
 2. Ensure the closure returns something for **every** element; the new array is built from those return values.

 Example — uppercase every string:

 ```swift
 let lower = ["apple", "banana", "cherry"]
 let upper = lower.map { $0.uppercased() }   // ["APPLE", "BANANA", "CHERRY"]
 ```

 Here `Element` is `String` and `Result` is also `String`, but you could just as easily convert numbers to strings, models to view-models, and so on.

 */

let lowerCaseLetters = ["a", "z", "b", "x", "c", "y"]
let upperCaseLetters = lowerCaseLetters.map { (aLetter: String) -> String in
    let upperCaseOfLetter = aLetter.uppercased()
    
    return upperCaseOfLetter
}

/*:
 As another example, let's create two separate arrays based on our previously created `guestList`:
 - One contains the ages of guests
 - The other contains only the names of guests
 - important: notice the return type of each closure matches the return value inside the closure's body
 
 
 */

let listOfAgesFromGuests = guestList.map { (aGuest: Guest) -> Int in
    return aGuest.age
}

let listOfNamesFromGuests = guestList.map { (aGuest: Guest) -> String in
    return aGuest.name
}

/*:
 ## `reduce(_:_:)`

 `reduce` walks through a collection and **combines all elements into a single value**—for example, turning an array of numbers into their sum or product.

 ### Signature

 ```swift
 (Result, Element) -> Result
 ```

 * **`Element`** – the element type stored in the array.
 * **`Result`** – the running total’s type (often—but not always—the same as `Element`).

 The closure receives two parameters on every iteration:

 1. **Accumulator** (`Result`) – the value produced so far (you supply the initial value when you call `reduce`).
 2. **Current element** (`Element`) – the next item from the array.

 The closure must return the **updated accumulator**, which `reduce` then feeds into the next cycle. After the last element, the final accumulator is returned.

 Example – sum an array of `Int` values:

 ```swift
 let numbers   = [1, 2, 3, 4]
 let totalSum  = numbers.reduce(0) { partialSum, next in
     partialSum + next        // Result is Int
 }
 // totalSum == 10
 ```

 > **Tip:** Because `reduce` is non-mutating, the original array stays unchanged.

 */

let randomNumbers = [2, 1, 6, 2, 8, 3, 10, -1]
let sumOfRandomNumbers = randomNumbers.reduce(0) { (sumSoFar, anInt) -> Int in
    let newSum = sumSoFar + anInt
    
    return newSum
}


/*:

 `reduce()` takes a starting value and a closure as two arguments. Notice that the closure follows the (). Swift allows this as part of the closure syntax.
 
Looking back at the map example. Notice that since there was only a single argument that is a closure, you could drop the ().
 
 ```
 let listOfAgesFromGuests = guestList.map { (aGuest: Guest) -> Int in ... }
 ```
 
 This could have been written as:
 
 ```
 let listOfAgesFromGuests = guestList.map() { (aGuest: Guest) -> Int in ... }
 ```
 
 These are the same, the first takes advantage of some "syntactical sugar" that Swift offers.
 
 In the case of the reduce example, there are two arguments, and the first argument needs to be in the ().
 
 ```
 let sumOfRandomNumbers = randomNumbers.reduce(0) { (sumSoFar, anInt) -> Int in ... }
 ```
 
 */

let namesCombined = guestList.reduce("") { (sentence, aGuest) -> String in
    let newSentence = aGuest.name + ", " + sentence
    
    return newSentence
}

/*:
 ## CHALLENGE!
 
 Practice using the high order functions by completing the following:
 */

// sort these numbers
let numbersToSort = [2, 4, 4, 2, 1, 0]


// sort the guests by name
let guestsToSort = [sam, eric, sara, charlie]


// sort the guests by age, but in descending order (youngest at the front of the array)


// filter the guests to only include guests younger than 18 years


// filter the numbers to only include even numbers
let numbersToFilter = [2, 1, 1, 5, 6, 7, 10]


// map the numbers to be double their values (e.g. 5 gets mapped to 10)
let numbersToDouble = [2, 4, 6, 8]


// map the numbers into strings
let numbersToMapIntoStrings = [2, 4, 5, 1, 2, 2]


// reduce the numbers into a sum, but exclude negative numbers from the sum. Thus, your reduce closure should reduce this array to equal 10
let numbersToSum = [-2, -5, -4, 5, -5, 5]


/*:
 We've learned more on how to use closures in our code, specifically with higher order functions, in order to clean up our code and make it more efficient.
 
 But we can make it EVEN MORE efficient! In the next section we'll learn some shorthand for writing closures.
 */

//: [Previous](@previous) | [Next](@next)

