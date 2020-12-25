import UIKit

// 연산자

// 스위프트의 나머지 연산과 나누기 연산자
// 스위프트는 서로 다른 타입 간의 연산이 엄격히 제한되어 있다
// 스위프트에서는 부동소수점 타입도 나머지 연산이 가능하다
let number: Double = 5.0
var result: Double = number.truncatingRemainder(dividingBy: 1.5) // 5.0을 1.5로 나누면 0.5가 남으므로 0.5가 반환된다
print(result)
result = 12.truncatingRemainder(dividingBy: 2.5) // 2.0
print(result)

// 일반적인 나누기 연산은 다른 프로그래밍 언어들과 마찬가지로 정수만을 결과값으로 반환한다
var resultInt: Int = 5 / 3 // 1
print(resultInt)
resultInt = 10 / 3 // 3
print(resultInt)

// 비교 연산자
print(5 == 5) // ==, != 연산자는 값을 비교한다
print(5 != 4)

class Person {
    var name: String = ""
}

var person1: Person = Person()
person1.name = "esbae"
var person2: Person = Person()
person2.name = "cs"
var person3 = person1

// ===, !== 연산자는 참조를 비교한다
print(person1 !== person2)
print(person1 === person3)

// 전위 연산자 정의
prefix operator **

prefix func **(value: Int) -> Int {
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive) // 25

// 후위 연산자 정의
postfix operator **
postfix func ** (value: Int) -> Int {
    return value + 10
}

let five: Int = 5
let fivePlusTen: Int = five**

print(fivePlusTen) // 15
// 만약 하나의 피연산자에 전위연산자와 후위연산자를 모두 사용하면 후위연산자가 먼저 적용된다
