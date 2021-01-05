import UIKit

// 클로저 Closure
// 변수, 상수가 선언된 위치에서 참조를 획득하고 저장 가능한 문법
// 클로저는 크게 세 가지 형태가 있다
// 1. 이름이 있으면서 어떤 값도 획득하지 않는 전역함수의 형태
// 2. 이름이 있으면서 다른 함수 내부의 값을 획득할 수 있는 중첩된 함수의 형태
// 3. 이름이 없고 주변 문맥에 따라 값을 획득할 수 있는 축약 문법으로 작성한 형태
// 클로저는 표현형식이 매우 다양하다
// 1. 매개변수와 반환 값의 타입을 생략 가능
// 2. 단 한줄의 코드만 작성되어 있다면 암시적으로 이를 반환 값으로 취급한다
// 3. 축약된 전달인자 이름을 사용할 수 있다
// 4. 후행 클로저 문법을 사용할 수 있다

/* 기본 클로저 */
let names: [String] = ["wizplan", "eric", "esbae", "jenny"]

// 정렬을 위한 함수 전달
func backwards(first: String, second: String) -> Bool {
    print("\(first) \(second) 비교중")
    return first > second
}

let reserved: [String] = names.sorted(by: backwards)
print(reserved) // ["wizplan", "jenny", "esbae", "eric"]

// 위 코드를 클로저를 사용해 코드를 간결하게 작성하기
// 통상적인 클로저 표현은 아래와 같다
/*
 { (매개변수들) -> 반환 타입 in
     실행 코드
 }
*/
let reversedUsingCloser: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
    return first > second
})
print(reversedUsingCloser) // ["wizplan", "jenny", "esbae", "eric"]

/* 후행 클로저 */
// 함수나 메서드의 소괄호를 닫은 후 작성하는 클로저
let reversedUsingTrailingCloser: [String] = names.sorted() { (first: String, second: String) -> Bool in
    return first > second
}

// 소괄호까지도 생략할 수 있다
let reversedUsingTrailingCloser2: [String] = names.sorted { (first: String, second: String) -> Bool in
    return first > second
}

/* 클로저 표현 간소화 */
// 1. 문맥을 이용한 타입 유추
// 매개변수의 타입이나 반환 값의 타입을 생략할 수 있다
let reserved2: [String] = names.sorted { (first, second) in
    return first > second
}

// 2. 단축 인자 이름
// $0, $1, $2, $3, ...과 같이 $와 숫자의 조합으로 매개변수의 이름을 단축시킬 수 있다
let reserved3: [String] = names.sorted {
    return $0 > $1
}

// 3. 암시적 반환 표현
// 클로저 내부의 실행문이 단 한줄이라면 return 키워드가 없어도 암시적으로 해당 실행문을 반환 값으로 사용할 수 있다
let reserved4: [String] = names.sorted { $0 > $1 }

// 4. 연산자 함수
// 클로저는 매개변수의 타입과 반환 타입이 연산자를 구현한 함수의 모양과 동일하다면
// 연산자만 표기하더라도 알아서 연산하고 반환한다
// 참고로 스위프트에서 연산자도 함수로 구현되어 있다
/*
 연산자 정의
 public func ><T: Comparable>(lhs: T, rhs: T) -> Bool
*/
let reserved5: [String] = names.sorted(by: >)

/* 값 획득 */
// 클로저는 자신이 정의된 주변 문맥을 통해 상수나 변수를 획득할 수 있다
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)

let first: Int = incrementByTwo() // 2
let second: Int = incrementByTwo() // 4
let third: Int = incrementByTwo() // 6

// 클로저는 참조 타입이다
let sameWithIncrementByTwo: (() -> Int) = incrementByTwo

let first2: Int = sameWithIncrementByTwo() // 8
let second2: Int = sameWithIncrementByTwo() // 10

/* 탈출 클로저 */
// 함수의 전달인자로 전달한 클로저가 함수 종료 후에 호출될 때 클로저가 함수를 탈출한다escape고 표현한다
// 매개변수 이름의 콜론 뒤에 @escaping키워드로 클로저가 탈출하는 것을 허용함을 명시해줄 수 있다

/* 탈출 클로저를 매개변수로 갖는 함수 */
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

/* 함수를 탈출하는 클로저의 예 */
typealias VoidVoidClosure = () -> Void
let firstClosure: VoidVoidClosure = {
    print("Clousre A")
}

let secondClosure: VoidVoidClosure = {
    print("Clousre B")
}

// first와 second 매개변수 클로저는 함수의 반환 값으로 사용될 수 있으므로 탈출 클로저다
func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure,
                      shouldReturnFirstClone: Bool) -> VoidVoidClosure {
    // 전달인자로 받은 클로저를 함수 외부로 다시 반환하기 때문에 함수를 탈출하는 클로저다
    return shouldReturnFirstClone ? first : second
}

// 함수에서 반환한 클로저가 함수 외부의 상수에 저장되었다
let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClone: true)

returnedClosure() // Closure A

var closures: [VoidVoidClosure] = []

// closure 매개변수 클로저는 함수 외부의 변수에 저장될 수 있으므로 탈출 클로저다
func appendClosure(closure: @escaping VoidVoidClosure) {
    // 전달인자로 전달받은 클로저가 함수 외부의 변수 내부에 저장되므로 함수를 탈출한다
    closures.append(closure)
}

// 클래스 인스턴스 메서드에 사용되는 탈출, 비탈출 클로저
func functionWithNoescapeClosure(closure: VoidVoidClosure) {
    closure()
}

func functionWithEscapingClosure(completionHandler: @escaping
                                    VoidVoidClosure) -> VoidVoidClosure {
    return completionHandler
}

class SomeClass {
    var x = 10
    
    func runNoescapeClosure() {
        // 비탈출 클로저에서 self 키워드 사용은 선택 사항이다
        functionWithNoescapeClosure { x = 200}
    }
    
    func runEscapingClosure() -> VoidVoidClosure {
        // 탈출 클로저에서는 명시적으로 self 키워드를 사용해야 한다
        return functionWithEscapingClosure { self.x = 100}
    }
}

let instance: SomeClass = SomeClass()
instance.runNoescapeClosure()
print(instance.x) // 200

let returnedClosure2: VoidVoidClosure = instance.runEscapingClosure()
returnedClosure2()
print(instance.x) // 100
