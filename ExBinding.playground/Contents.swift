import UIKit

// MARK: Modle

@propertyWrapper
struct MyBinding<T> {
    private var get: () -> T
    private var set: (T) -> Void

    var wrappedValue: T {
        get { get() }
        nonmutating set { set(newValue) }
    }
    
    init(get: @escaping () -> T, set: @escaping (T) -> Void) {
        self.get = get
        self.set = set
    }
}


// MARK: Ex1
/*
var _age = 0

var ageBinding: MyBinding<Int> = {
    MyBinding(get: {
        _age
    }, set: {
        _age = $0
    })
}()

print(ageBinding.wrappedValue)
_age = 2
print(ageBinding.wrappedValue)

/*
 0
 2
 */

 */
 
// MARK: Ex2
protocol Peronable {
    var age: Int { get }
}

struct Person: Peronable {
    @MyBinding var age: Int
}

var _age = 0
var ageBinding: MyBinding<Int> = {
    MyBinding(get: {
        _age
    }, set: {
        _age = $0
    })
}()

var person: Peronable = {
    Person(age: ageBinding)
}()

print(ageBinding.wrappedValue)
_age = 2 // setter가 가능
print(ageBinding.wrappedValue)
