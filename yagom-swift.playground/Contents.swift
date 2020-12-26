import UIKit

// 함수
// 함수에서는 소괄호 - ()를 생략할 수 없다
// 재정의(오버라이드), 중복정의(오버로드)를 지원한다

// 함수의 정의와 호출
/*
 func 함수 이름(매개변수...) -> 반환 타입 {
   실행 구문
   return 반환 값
 }
*/

func hello(name: String) -> String {
    return "Hello \(name)!"
}

let helloJenny: String = hello(name: "Jenny")
print(helloJenny) // Hello Jenny!

/* return 키워드 생략 가능 */
// 구현부가 반드시 한 줄이어야 하고, 그 한 줄의 결과 값의 타입이 반환 타입과 같아야 한다
func introduce(name: String) -> String {
    "제 이름은 " + name + "입니다" // return "제 이름은 \(name)입니다"와 같은 동작을 한다
}

let introduceJenny: String = introduce(name: "Jenny")
print(introduceJenny) // 제 이름은 Jenny입니다

/* 매개변수 */
func helloWorld() -> String {
    return "Hello, world!"
}

print(helloWorld()) // Hello, world!

// 스위프트는 매개변수를 넘길 때 매개변수 이름을 지정해주어야 한다
func sayHello(myName: String, yourName: String) -> String {
    return "Hello \(yourName)! I'm \(myName)"
}

print(sayHello(myName: "esbae", yourName: "Jenny")) // Hello Jenny! I'm esbae

/* 매개변수 이름과 전달인자 레이블 */
// 매개변수 이름과 함께 전달인자 레이블을 별도로 지정하면 함수 외부에서 매개변수의 역할을 좀 더 명확히 할 수 있다
/*
 func 함수 이름(전달인자 레이블: 매개변수 이름: 매개변수 타입, ...) {
   실행 구문
   return 반환 값
 }
*/
func sayHello(from myName: String, to yourName: String) -> String {
    return "Hello \(yourName)! I'm \(myName)"
}

print(sayHello(from: "esbae", to: "Jenny")) // Hello Jenny! I'm esbae

// 전달인자 레이블이 없는 함수
func sayHello(_ name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello("Chope", 2)) // Hello Chope! Hello Chope!

// 전달인자 레이블을 다르게 지정해 함수를 중복정의하기
func sayHello(to name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

func sayHello(to name: String, repeatCount times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello(to: "Chope", 2)) // Hello Chope! Hello Chope!
print(sayHello(to: "Chope", repeatCount: 2)) // Hello Chope! Hello Chope!

// 매개변수 기본값
// 매개변수 기본값을 설정한 함수는 설정하지 않은 함수와 다른 함수로 간주되어 오버로드된다
func sayHello(_ name: String, times: Int = 3) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello("Hana")) // Hello Hana! Hello Hana! Hello Hana!
print(sayHello("Joe", times: 2)) // Hello Joe! Hello Joe!

/* 가변 매개변수와 입출력 매개변수 */
// 매개변수의 갯수를 정확히 모를 때 가변 매개변수를 사용할 수 있다(0개 이상)
// 가변 매개변수로 들어온 인자는 배열처럼 사용할 수 있다
func sayHelloFriends(me: String, friends names: String...) -> String {
    var result: String = ""
    
    for friend in names {
        result += "Hello \(friend)!" + " "
    }
    
    result += "I'm " + me + "!"
    return result
}

print(sayHelloFriends(me: "esbae", friends: "Johansson", "Jay", "Wizplan")) // Hello Johansson! Hello Jay! Hello Wizplan! I'm esbae!
print(sayHelloFriends(me: "esbae")) // I'm esbae!

// 함수의 전달인자로 값을 전달할 때는 값을 복사해서 전달한다
// 값이 아닌 참조를 전달하려면 입출력 매개변수를 사용한다
var numbers: [Int] = [1, 2, 3]

func nonReferenceParameter(_ arr: [Int]) {
    var copiedArr: [Int] = arr
    copiedArr[1] = 1
}

func referenceParameter(_ arr: inout [Int]) {
    arr[1] = 1
}

nonReferenceParameter(numbers)
print(numbers[1]) // 2

referenceParameter(&numbers)
print(numbers[1]) // 1

// 반환이 없는 함수
// 반환타입에 Void를 명시하거나 아예 생략하면 된다
func sayHelloWorld() {
    print("Hello, world!")
}
sayHelloWorld() // Hello, world!

func sayHelloWorld(from myName: String, to yourName: String) {
    print("Hello \(yourName)! I'm \(myName)")
}
sayHelloWorld(from: "esbae", to: "Mijeong") // Hello Mijeong! I'm esbae

func sayGoodbye() -> Void {
    print("Good bye")
}
sayGoodbye() // Good bye

// 데이터 타입으로서의 함수
// 스위프트의 함수는 일급 객체이므로 하나의 데이터 타입으로 사용할 수 있다
/*
 (매개변수 타입의 나열) -> 반환 타입
*/
typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: CalculateTwoInts = addTwoInts
print(mathFunction(2, 5)) // 7

mathFunction = multiplyTwoInts
print(mathFunction(2, 5)) // 10

func printMathResult(_ mathFunction: CalculateTwoInts, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5) // Result: 8

func chooseMathFunction(_ toAdd: Bool) -> CalculateTwoInts {
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(chooseMathFunction(true), 3, 5) // Result: 8

// 중첩 함수
// 함수 내부에 함수를 구현해서 사용할 수 있다
typealias MoveFunc = (Int) -> Int

func functionForMove(_ shouldGoLeft: Bool) -> MoveFunc {
    func goRight(_ currentPosition: Int) -> Int {
        return currentPosition + 1
    }

    func goLeft(_ currentPosition: Int) -> Int {
        return currentPosition - 1
    }
    
    return shouldGoLeft ? goLeft: goRight
}

var position: Int = 3

let moveToZero: MoveFunc = functionForMove(position > 0)
print("원점으로 갑시다")
while position != 0 {
    print("\(position)...")
    position = moveToZero(position)
}
// 3...
// 2...
// 1...
print("원점 도착!")

// 종료되지 않는 함수
// 정상적으로 종료되지 않는 함수다
// 오류를 발생시키거나 중대한 시스템 오류를 보고하는 등의 일을 하고 프로세스를 종료해 버린다
// 비반환 함수Nonreturning function 혹은 비반환 메서드Nonreturning method 라고도 한다
// 반환 타입을 Never라고 명시해주면 된다
func crashAndBurn() -> Never {
    fatalError("Something very, very bad happened")
}

//crashAndBurn() // 프로세스 종료 후 오류 보고

func someFunction(isAllIsWell: Bool) {
    guard isAllIsWell else {
        print("마을에 도둑이 들었습니다!")
        crashAndBurn()
    }
    print("All is well")
}

someFunction(isAllIsWell: true) // All is well
//someFunction(isAllIsWell: false) // 마을에 도둑이 들었습니다!
// 프로세스 종료 후 오류 보고

// 반환 값을 무시할 수 있는 함수
// 함수의 반환 값이 꼭 필요하지 않을 때 @discardableResult속성을 사용하면 된다
func say(_ something: String) -> String {
    print(something)
    return something
}

@discardableResult func discardableResultSay(_ something: String) -> String {
    print(something)
    return something
}

// 반환 값을 사용하지 않아서 컴파일러가 경고를 표시할 수 있다
say("hello")

// 반환 값을 사용하지 않을 수 있음을 미리 알렸기 때문에
// 반환 값을 사용하지 않아도 컴파일러가 경고하지 않는다
discardableResultSay("hello")
