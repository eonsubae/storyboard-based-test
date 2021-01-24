/* 제네릭 */
// 어떤 타입에도 유연하게 대응하도록 만들어주는 문법
/*
  제네릭을 사용하는 타입 이름 <타입 매개변수>
  제네릭을 사용하는 함수 이름 <타입 매개변수> (함수의 매개변수...)
*/

// 전위 연산자 구현
prefix operator **

prefix func ** (value: Int) -> Int {
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive) // 25

// 그런데 위와 같은 구현으로는 UInt같은 대응하지 못한다
// 제네릭과 프로토콜로 보다 유연하게 대응할 수 있다
prefix func ** <T: BinaryInteger> (value: T) -> T {
    return value * value
}

let minusSix: Int = -6
let six: UInt = 6

let sqrtMinusSix: Int = **minusSix
let sqrtSix: UInt = **six

print(sqrtMinusSix) // 36
print(sqrtSix) // 36

// 두 정수값을 교환하는 함수
func swapToInts(_ a: inout Int, _ b: inout Int) {
    let tempA: Int = a
    a = b
    b = tempA
}

var numberOne: Int = 5
var numberTwo: Int = 10

swapToInts(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)") // 10, 5

// 그런데 위의 구현은 Double, String 등의 타입에 대응하지 못한다
// 제네릭을 활용한 교환
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tempA: T = a
    a = b
    b = tempA
}

var stringOne: String = "A"
var stringTwo: String = "B"

var anyOne: Any = "1"
var anyTwo: Any = "Two"

swapTwoValues(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)") // 5, 10

swapTwoValues(&stringOne, &stringTwo)
print("\(stringOne), \(stringTwo)") // B, A

swapTwoValues(&anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)") // Two, 1

// 제네릭을 사용한 Stack 구조체 타입
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var doubleStack: Stack<Double> = Stack<Double>()

doubleStack.push(1.0)
print(doubleStack.items)
doubleStack.push(2.0)
print(doubleStack.items)
doubleStack.pop()
print(doubleStack.items)

var stringStack: Stack<String> = Stack<String>()

stringStack.push("1")
print(stringStack.items)
stringStack.push("2")
print(stringStack.items)
stringStack.pop()
print(stringStack.items)

var anyStack: Stack<Any> = Stack<Any>()

anyStack.push(1.0)
print(anyStack.items)
anyStack.push("2")
print(anyStack.items)
anyStack.push(3)
print(anyStack.items)
anyStack.pop()
print(anyStack.items)

// 제네릭 타입 확장
extension Stack {
    var topElement: Element? {
        return self.items.last
    }
}

print(doubleStack.topElement)
print(stringStack.topElement)
print(anyStack.topElement)

// 타입 제약
// 종종 특정 타입에 한정된 제네릭을 사용해야할 때가 있다
// 타입 제약은 클래스 또는 프로토콜로만 만들 수 있다(열거형, 구조체 등은 불가)
func swapToValues<T: BinaryInteger>(_ a: inout T, _ b: inout T) {
    // 함수 구현
}

struct StackB<Element: Hashable> {
    // 구조체 구현
}

// 제약 추가
// 위 swapToValues에서는 정수에 대한 제약인 BinaryInteger의 제약만 추가했다
// 그런데 만약 정수와 실수를 함께 받고 싶다고 해도 정수와 실수를 함께 포함하는 객체가 없으므로 한번에 처리는 불가능하다
// where로 실수에 대한 제약을 추가할 수 있다
func swapToValues<T: BinaryInteger>(_ a: inout T, _ b: inout T) where T: FloatingPoint {
    // 함수 구현
}

// 제약을 이용한 뺄셈
// 만약 BinaryInteger라는 제약이 없으면 뺄셈연산자를 사용할 수 없으므로 에러가 발생한다
func subtractTwoValue<T: BinaryInteger>(_ a: T, _ b: T) -> T {
    return a - b
}

func makeDictionaryWithTwoValue<Key: Hashable, Value>(key: Key, value: Value) -> Dictionary<Key, Value> {
    let dictionary: Dictionary<Key, Value> = [key:value]
    return dictionary
}

// 프로토콜의 연관 타입
// 타입 매개변수의 역할을 프로토콜에서 수행할 수 있도록 만들어진 기능
protocol Container {
    associatedtype ItemType // 그 어떤것이어도 상관없지만, 하나의 타입임은 분명하다
    var count: Int { get }
    mutating func append(_ item: ItemType)
    subscript(i: Int) -> ItemType { get }
}

class MyContainer: Container {
    var items: Array<Int> = Array<Int>()
    
    var count: Int {
        return items.count
    }
    
    func append(_ item: Int) {
        items.append(item)
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct IntStack: Container {
    typealias ItemType = Int
    var items = [ItemType]()
    
    mutating func push(_ item: ItemType) {
        items.append(item)
    }
    mutating func pop() -> ItemType {
        return items.removeLast()
    }
    
    // Container 프로토콜 준수를 위한 구현
    mutating func append(_ item: ItemType) {
        self.push(item)
    }
    var count: ItemType {
        return items.count
    }
    subscript(i: Int) -> ItemType {
        return items[i]
    }
}

struct StackC<Element>: Container {
    // 기존 Stack<Element> 구조체 구현
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // Conatiner 프로토콜 준수를 위한 구현
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// 제네릭 서브스크립트
// 서브스크립트에도 제네릭을 활용해 유연하게 구현할 수 있다
extension StackC {
    subscript<Indices: Sequence>(indices: Indices) -> [ItemType]
        where Indices.Iterator.Element == Int {
            var result = [ItemType]()
            for index in indices {
                result.append(self[index])
            }
            return result
        }
}

var integerStack: StackC<Int> = StackC<Int>()
integerStack.append(1)
integerStack.append(2)
integerStack.append(3)
integerStack.append(4)
integerStack.append(5)

print(integerStack[0...2])
