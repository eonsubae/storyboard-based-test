import UIKit

// 타입 별칭 Type alias
typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: MyInt = 100 // MyInt는 Int의 또 다른 이름이다
var year: YourInt = 2080 // YourInt도 Int의 또 다른 이름이다

year = age // 같은 Int 타입이므로 할당이 가능하다

// 튜플
// 튜플은 타입의 이름이 따로 지정되어 있지 않은 프로그래머가 만드는 타입을 의미한다
// 지정된 데이터의 묶음이라고 할 수 있다
var person: (String, Int, Double) = ("esbae", 100, 182.5) // String, Int, Double값을 가지는 튜플

// 인덱스로 값을 뺴오기
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

// 인덱스로 값을 할당하기
person.1 = 31
person.2 = 181.5
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

// 튜플 요소 이름 지정
// 각각의 요소에 이름을 붙일 수 있다
var namedPerson: (name: String, age: Int, height: Double) = ("esbae", 30, 182.5)

// 요소 이름으로 값을 빼오기
print("이름: \(namedPerson.name), 나이: \(namedPerson.age), 신장: \(namedPerson.height)")

// 요소 이름으로 값을 할당하기
namedPerson.name = "배언수"
namedPerson.age = 31

// 요소 이름을 지정해도 기존처럼 인덱스도 사용할 수 있다
print("이름: \(namedPerson.0), 나이: \(namedPerson.1), 신장: \(namedPerson.2)")

// 튜플 별칭 지정 Tuple alias
typealias PersonTuple = (name: String, age: Int, height: Double)

let esbae: PersonTuple = ("esbae", 30, 181.5)
let eric: PersonTuple = ("eric", 32, 183.5)

print("이름: \(esbae.name), 나이: \(esbae.age), 신장: \(esbae.height)")
print("이름: \(eric.name), 나이: \(eric.age), 신장: \(eric.height)")
