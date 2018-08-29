/*:
 # Memory Management
 
 ## Retain Counts
 Swift uses Automatic Reference Counting, or ARC, to manage when an instance is in kept in memory and what it gets deleted.
 
 #How does it work
 Once an instance of a class is created, ARC will keep track of its reference count, or retain count. Let's look at an example:
 
 We create a class called Person and add an initizalizer and a deinit method as well as a single property.
 */

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

/*:
 Each instance of a class has its own retain count. This counter is what tells ARC to keep the instance in memory or delete it from memory. When the retain count is zero, ARC will delete the instance.
 
 Let's create an instance of this class and assign it to a local variable:
 */

let eric = Person(name: "Eric")

/*:
 Since `eric` references the new instance, the retain count is now 1. Let's create another instance of `Person`
 */

let jack = Person(name: "Jack")

/*:
 Again, this new instance has a retain count of 1. Each instances have a retain count of one because each instance has one variable "pointing" at each instance.
 
 So now we saw how we **increment** a retain count, let's see how we decrement one
 
 ## Decreameting a retain count
 We'll use the same two instances, `Person(name: "Eric")` and `Person(name: "Jack")`, and create a new variable and set it equal to `erick`.
 */

var jacksBestFriend: Person? = eric

/*:
Any guesses on what the retain count is of the first instance?
 
 It's two. The first instance, `Person(name: "Eric")`, now has two variables pointing to it. How is this possible?
 
 On the previous line of code, we assign `jacksBestFriend` to equal `eric`. But, what happened under the hood is the variable, or pointer, `jacksBestFriend` now *points* to whatever `eric` *points to* which is the first instance, `Person(name: "Eric")`. Let's update `jacksBestFriend` to not point to `eric`:
 */

jacksBestFriend = nil

/*:
 Now the retain count for `Person(name: "Eric")` is back to one since `eric` still points to that instance. Overall, the retain count for all instances depend on how many properties, variables, and constants are pointing to that instance.

 ## When do retain counts go to zero
 A common place for an instance's retain count to go to zero is local variables. Let's take a look:
 */

func createPersonInstance() {
    let bella = Person(name: "Bella")
    
    print("New person's name is \(bella.name)")
}

print("function call starts")
createPersonInstance()
print("function call ends")

/*:
 Look in the console and see that Bella is initalized after the function starts and deinitialized after the function ends.
 
 ![deinit](./deinit.png)
 
 This is because the local variable is removed when the function that created the local variable fell out of scope.
 
 Another common case is when you present a new view controller onto the screen a new instance of that view controller is initalized. But, when the screen goes away, by a back button for example, the view controller is then deinitialized.
 
 ## What is a reference type
 There are two kinds a type can be; either a **Reference Type** or a **Value Type**. Let's talk about reference types first.
 
 ### What can be reference types
 In Swift, there are `classes`, `structs`, and `enums`. Classes are the only type that can be a reference type. All others, are value types. What does this mean in our code?
 
 ### Functions, passed by value or pass by reference
 Let's look at the following code and see what's going on:
 */

let billy = Person(name: "Billy")

func printDetailsOf(_ person: Person) {
    print(person.name)
}

printDetailsOf(billy)

/*:
 So, what's going on when we call the function `printDetailsOf`? Since, the variable billy points to an instance of a Person class, which is a reference type, the instance is passed by reference. Meaning, only the pointer is given to the function, the pointer that contains the instance in memory.
 
 Similarly, when we created the variable `jacksBestFriend` previously, and set it equal to `eric`, `jacksBestFriend` was assigned a pointer to the same place in memory as `eric` which was `Person(name: "Eric")`.
 
 ### Value Types
 Now, if `Person` was a value type instead, in other words a `struct` vs a `class`, different operations would occur in our two situations:
 
 In the first situation, the function would make a copy of `billy` therefore, copy the values of billy which would be the name.
 
 In the second situation, again, the values would be copied. Once we assign `jacksBestFriend` to `eric`, `jacksBestFriend` would have its own copy of `eric`'s values. Let's look test that out:
 */

//using reference types
let molly = Person(name: "Molly")
var erickBestFriend = molly

print("before changing the name: \(molly.name)")
erickBestFriend.name = "Molls"

print("after changing the name: \(molly.name)")

/*:
 Notice when we changed the name of `erickBestFriend` it changed the name of `molly`. This is because both `erickBestFriend` and `molly` point to the same instance.
 
 Now, let's try this with a value type, `Customer`:
 */

struct Customer {
    var name: String
}

//using value types
let danny = Customer(name: "Danny")
var bankCustomer = danny

print("before changing the name: \(danny.name)")
print(bankCustomer.name)
bankCustomer.name = "Dan"

print("after changing the name: \(danny.name)")
print(bankCustomer.name)

/*:
 Now in this case, notice how the value of `danny.name` remained the same. While, `bankCustomer.name` changed to the new name. This is because `bankCustomer` was a copy of `danny`
 
 ## Retain Cycles
 ARC has its common challenges, one is a retain cycle. A retain cycle occurs when two instances point at each other. Let's see how that looks:
 
 We have the following two classes:
 
 ![retain cycle classes](./retain-cycle-classes.png)
 
 - important: a person has a property of type Apartment. And, an apartment has a property of type Person.
 
 Let's create an instance of each classes and assign the person to the unit and the unit to the person:
 
 ![retain cycle-create instances](./retain-cycle-create-instances.png)
 
 Let's look at a graph the help use describe what's going on:
 
 ![retain cycle](./referenceCycle02_2x.png)
 
 Here, we created two instances, a Person instance stored in `john`, and an Apartment instance stored in `unit4A`. `john.apartment` points to the instance `unit4A` points to. Then, `unit4A.tenant` points to the instance `john` points to.
 
 ### The problem
 
 Here in the following graph, both variables `john` and `unit4A` no longer point to the instances `Person(name: "John Appleseed")` and `Apartment(unit: "4A")`. But, notice the two instances still point the each other. This is a problem. Since, each instance still has a retain count of 1, or not zero, they haven't been deinitalized from memory. In fact, both instances are unreachable.
 
 ![retain cycle-2](./referenceCycle03_2x.png)
 
 So, how do we fix this. We have to break the chain between the two instances somehow.
 
 By default, all variables, properties and constants are *strong* pointers. Meaning, they increament and decreament retain counts of instances each variable points to. This is where we can break the chain between two instances that point to each other.
 
 ## Weak References
 `weak` is a keyword that allows variables to point to an instnace but without increamenting its retain count. This makes the variable an optional. Since a weak variable does not increament the retain count, the instance the weak varible points to can be deinitialized, thus the variable can be `nil`.
 
 Let's try to fix our retain cycle using a weak variable:
 
 ![retain cycle classes-fixed](./retain-cycle-classes-fixed.png)
 
 Here we mark the tenant property as a *weak property*. This is what the graph looks like now:
 
 ![weak reference](./weakReference01_2x-1.png)
 
 - note: The variable, or pointer, from the apartment to the person is now a `weak` reference. Thus, the retain count for person is only one. The retain count for apartment is still two as it was perviously.
 
 Once the `john` variable is deleted, or no longer pointing at `Person(name: "John Appleseed")`, the Person instance's retain count goes from 1 to zero, thus the instance is removed from memory:
 
 ![person deinit](./weakReference02_2x.png)
 
 Once the person is deinitialized, now apartment's retain count went from 2 to 1, 1 being the `unit4A` variable. And like expected, once `unit4A` is removed, `Apartment(unit: "4A")` is deinitalized from memory:
 
 ![apartment deinit](./weakReference03_2x.png)
 
 ## Unowned References
 Unowned serves the same effect as `weak`, the retain count is not increamented or decreamented but this implicitly unwraps the optional for you. So, if you can guarentee that the instance an `unowned variable` points to will never be deinitalized when you use the unowned variable, then mark it as `unowned` vs `weak`.
 
 - important: Like force unwrapping an optional, if there is no value there, your app will crash. Thus, unowned variables are not used often.
 */









import Foundation

//: [Previous](@previous)
