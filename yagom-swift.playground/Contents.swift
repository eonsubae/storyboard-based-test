/* 맵, 필터, 리듀스 */
// 매개변수로 함수를 갖는 함수를 고차함수라 부른다
// 스위프트의 대표적 고차함수로는 맵, 필터, 리듀스가 있다

/* 맵 */
// 자신을 호출할 때 매개변수로 전달된 함수를 실행하여 결과를 다시 반환해주는 함수
// 기존 데이터를 변형할 때 많이 사용한다
// Sequence, Collection 프로토콜을 따르는 타입과 옵셔널은 맵을 사용할 수 있다
/*
  container.map(f(x))
      -> return f(container의 각 요소) - 새로운 컨테이너
*/
// for in 과 사용법은 크게 차이가 없으나 코드의 재사용, 스레드 세이프 측면에서 장점이 있다

// for-in 구문과 맵 메서드 사용 비교
let numbers: [Int] = [0, 1, 2, 3, 4]

var doubleNumbers: [Int] = [Int]()
var strings: [String] = [String]()

// for구문 사용
for number in numbers {
    doubleNumbers.append(number * 2)
    strings.append("\(number)")
}

print(doubleNumbers) // [0, 2, 4, 6, 8]
print(strings) // ["0", "1", "2", "3", "4"]

// map 메서드 사용
doubleNumbers = numbers.map({ (number: Int) -> Int in
    return number * 2
})
strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

print(doubleNumbers) // [0, 2, 4, 6, 8]
print(strings) // ["0", "1", "2", "3", "4"]

// 클로저 표현의 간략화

// 기본 클로저 표현식 사용
doubleNumbers = numbers.map({ (number: Int) -> Int in
    return number * 2
})

// 매개변수 및 반환 타입 생략
doubleNumbers = numbers.map({ return $0 * 2 })
print(doubleNumbers) // [0, 2, 4, 6, 8]

// 반환 키워드 생략
doubleNumbers = numbers.map({ $0 * 2 })
print(doubleNumbers) // [0, 2, 4, 6, 8]

// 후행 클로저 사용
doubleNumbers = numbers.map { $0 * 2 }
print(doubleNumbers) // [0, 2, 4, 6, 8]

// 클로저의 반복 사용
let evenNumbers: [Int] = [0, 2, 4, 6, 8]
let oddNumbers: [Int] = [0, 1, 3, 5, 7]
let multiplyTwo: (Int) -> Int = { $0 * 2 }

let doubleEvenNumbers = evenNumbers.map(multiplyTwo)
print(doubleEvenNumbers)

let doubleOddNumbers = oddNumbers.map(multiplyTwo)
print(doubleOddNumbers)

// 다양한 컨테이너 타입에서의 맵의 활용
let alphabetDictionary: [String: String] = ["a": "A", "b": "B"]

var keys: [String] = alphabetDictionary.map { (tuple: (String, String)) -> String in
    return tuple.0
}

keys = alphabetDictionary.map { $0.0 }

let values: [String] = alphabetDictionary.map { $0.1 }

print(keys)
print(values)

var numberSet: Set<Int> = [1, 2, 3, 4, 5]
let resultSet = numberSet.map { $0 * 2 }
print(resultSet)

let optionalInt: Int? = 3
let resultInt: Int? = optionalInt.map { $0 * 2}
print(resultInt)

let range: CountableClosedRange = (0...3)
let resultRange: [Int] = range.map { $0 * 2}
print(resultRange)

/* 필터 */
// 컨테이너 내부의 값을 걸러서 추출하는 고차함수

// 필터 메서드의 사용
let numbers2: [Int] = [0, 1, 2, 3, 4, 5]

let evenNumbers2: [Int] = numbers2.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers2)

let oddNumbers2: [Int] = numbers2.filter { (number: Int) -> Bool in
    return number % 2 == 1
}
print(oddNumbers2)

// 맵과 필터 메서드의 연계 사용
let mappedNumbers: [Int] = numbers.map { $0 + 3 }

let evenNumbers3: [Int] = mappedNumbers.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers3)

// 체이닝
let oddNumbers3: [Int] = numbers.map{ $0 + 3 }.filter{ $0 % 2 == 1}
print(oddNumbers3)

/* 리듀스 */
// 컨테이너 내부의 콘텐츠를 하나로 합하는 고차함수
let num = [1, 2, 3]

// 리듀스의 첫 번째 형태
var sum: Int = num.reduce(0, { (result: Int, next: Int) -> Int in
    print("\(result) + \(next)")
    // 0 + 1
    // 1 + 2
    // 3 + 3
    return result + next
})
print(sum)

let sub: Int = num.reduce(0, { (result: Int, next: Int) -> Int in
    print("\(result) - \(next)")
    // 0 - 1
    // -1 - 2
    // -3 - 3
    return result - next
})
print(sub)

let sumFromThree: Int = num.reduce(3) {
    print("\($0) + \($1)")
    // 3 + 1
    // 4 + 2
    // 6 + 3
    return $0 + $1
}
print(sumFromThree)

var subtractFromThree: Int = num.reduce(3) {
    print("\($0) - \($1)")
    // 3 - 1
    // 2 - 2
    // 0 - 3
    return $0 - $1
}
print(subtractFromThree)

let names: [String] = ["Chope", "Jay", "Joker", "Nova"]

let reducedNames: String = names.reduce("esbae's friend : ") {
    return $0 + ", " + $1
}
print(reducedNames)

// 리듀스의 두 번째 형태

sum = num.reduce(into: 0, { (result: inout Int, next: Int) in
    print("\(result) + \(next)")
    // 0 + 1
    // 1 + 2
    // 3 + 3
    result += next
})
print(sum)

subtractFromThree = num.reduce(into: 3, {
    print("\($0) - \($1)")
    // 3 - 1
    // 2 - 2
    // 0 - 3
    $0 -= $1
})
print(subtractFromThree)

var doubledNumbers: [Int] = num.reduce(into: [1, 2]) { (result: inout [Int], next: Int) in
    print("result: \(result) next: \(next)")
    // result: [1, 2] next: 1
    // result: [1, 2] next: 2
    // result: [1, 2, 4] next: 3

//    guard next.is else {
//        return
//    }
    if next % 2 != 0 {
        return
    }
    
    print("\(result) append \(next)")
    // [1, 2] append 2
    
    result.append(next * 2)
}
print(doubledNumbers) // [1, 2, 4]

// 필터와 맵을 사용
doubledNumbers = [1, 2] + num.filter { $0.isMultiple(of: 2) }.map { $0 * 2}
print(doubledNumbers) // [1, 2, 4]

var upperCasedNames: [String]
upperCasedNames = names.reduce(into: [], {
    $0.append($1.uppercased())
})
print(upperCasedNames) // ["CHOPE", "JAY", "JOKER", "NOVA"]

// 맵을 사용한 모습
upperCasedNames = names.map { $0.uppercased() }
print(upperCasedNames) // ["CHOPE", "JAY", "JOKER", "NOVA"]

// 맵, 필터, 리듀스의 연계
let n: [Int] = [1, 2, 3, 4, 5, 6, 7]

// 짝수를 걸러내 각 값에 3을 곱해준 뒤 모든 값을 더한다
var result: Int = n.filter { $0.isMultiple(of: 2) }.map{ $0 * 3 }.reduce(0) {
    $0 + $1
}
print(result) // 36

enum Gender {
    case male, female, unknown
}

struct Friend {
    let name: String
    let gender: Gender
    let location: String
    var age: UInt
}

var friends: [Friend] = [Friend]()

friends.append(Friend(name: "Yoobato", gender: .male, location: "발리", age: 26))
friends.append(Friend(name: "Jisoo", gender: .male, location: "시드니", age: 24))
friends.append(Friend(name: "JuHyun", gender: .male, location: "경기", age: 30))
friends.append(Friend(name: "JiYoung", gender: .female, location: "서울", age: 22))
friends.append(Friend(name: "SungHo", gender: .male, location: "충북", age: 20))
friends.append(Friend(name: "JungKi", gender: .unknown, location: "대전", age: 29))
friends.append(Friend(name: "YoungMin", gender: .male, location: "경기", age: 24))

// 서울 외의 지역에 거주하며 25세 이상인 친구
var r: [Friend] = friends.map {
    Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1)
}

r = r.filter { $0.location != "서울" && $0.age >= 25 }

let s: String = r.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") {
    $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세"
}
print(s)
/*
서울 외의 지역에 거주하며 25세 이상인 친구
Yoobato male 발리 27세
Jisoo male 시드니 25세
JuHyun male 경기 31세
JungKi unknown 대전 30세
YoungMin male 경기 25세
*/
