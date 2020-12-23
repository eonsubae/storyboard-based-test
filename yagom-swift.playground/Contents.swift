import UIKit

// 컬렉션(Array, Dictionary, Set)
// 튜플 이외에도 데이터를 묶어서 저장하고 관리할 수 있는 타입인 컬렉션 타입이 있다

// Array
// 같은 타입의 데이터를 일렬로 나열한 후 순서대로 저장하는 컬렉션
// 필요에 따라 버퍼의 크기를 조절해주므로 길이를 신경쓰지 않아도 된다

// 대괄호를 사용해 배열을 선언
var names: Array<String> = ["esbae", "cs", "yh"]

// 위 선언과 동일한 작동
var names2: [String] = ["esbae", "cs", "yh"]

// Any타입의 배열
var emptyArray: [Any] = [Any]() // 어떤 타입의 데이터든 저장 가능한 빈 배열을 todtjd
var emptyArray2: [Any] = Array<Any>() // 위와 동일한 동작을 하는 코드다

// 배열의 타입을 정확히 명시해주었다면 []만으로도 빈 배열을 생성할 수 있다
var emptyArray3: [Any] = []
print(emptyArray.isEmpty) // true
print(names.count) // 3

// 인덱스로 배열의 요소에 접근하기
// 첫번째 요소는 first로 마지막 요소는 last로 접근할 수 있다
print(names.first) // esbae
print(names[1]) // cs
print(names.last) // yh
// print(names[3]) 인덱스를 벗어났으므로 에러 발생

// append로 추가
// contentsOf에 배열로 여러값을 추가할 수도 있다
names.append("elsa")
names.append(contentsOf: ["john", "max"])
print(names) // ["esbae", "cs", "yh", "elsa", "john", "max"]

// firstIndex(of:) 메서드로 요소의 인덱스를 가져오기 index(of:)는 디프리케이티드 되었다
print(names.firstIndex(of: "elsa")) // 3

// insert로 중간에 삽입하기
names.insert("happy", at: 2)
names.insert(contentsOf: ["jh", "ms"], at: 3)
print(names)

// remove, removeFirst, removeLast로 요소를 제거하기
// 제거된 요소는 반환된다
let firstItem: String = names.removeFirst() // esbae
let lastItem: String = names.removeLast() // max
let indexZeroItem: String = names.remove(at: 0) // cs

// 범위 연산자로 여러 요소들을 가져오기
let oneToThree = names[1...3] // ["jh", "ms", "yh"]
names[1...3] = ["jh2", "ms2", "yh2"] // 여러 값을 범위연산자로 변경할 수도 있다
print(names) // ["happy", "jh2", "ms2", "yh2", "elsa", "john"]

