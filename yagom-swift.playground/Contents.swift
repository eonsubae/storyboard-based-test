import UIKit

// 컬렉션(Array, Dictionary, Set)
// 튜플 이외에도 데이터를 묶어서 저장하고 관리할 수 있는 타입인 컬렉션 타입이 있다

// Dictionary
// 키와 값의 쌍으로 구성된 컬렉션 타입
// 키가 하나이거나 여러 개일수도 있다. 그러나 키를 중복해서 사용할 수는 사용할 수 없다

// 딕셔너리 선언과 생성
// 타입 얼라이어스로 조금 더 단순하게 표현할 수 있다
typealias StringIntDictionary = [String: Int]

// 키는 String, 값은 Int 타입인 빈 딕셔너리를 생성한다
var numberForName: Dictionary<String, Int> = Dictionary<String, Int>()

// 위 선언의 축약 표현
var numberForName2: [String: Int] = [String: Int]()

// 위 코드와 같은 동작
var numberForName3: StringIntDictionary = StringIntDictionary()

// 딕셔너리의 키와 밸류 타입을 명시하면 [:]만으로도 빈 딕셔너리를 생성할 수 있다
var numberForName4: [String: Int] = [:]

// 초기값을 설정하며 선언하기
var numberForName5: [String: Int] = ["esbae": 100, "cs": 200, "jenny": 300]

print(numberForName5.isEmpty) // false
print(numberForName5.count) // 3

/* 딕셔너리의 사용 */
// 배열과 달리 잘못된 키에 접근해도 nil이 반환될 뿐 에러가 발생하지 않는다
// 특정 키의 값을 제거하려면 removeValue(forKey:)메서드를 사용한다
// removeValue메서드를 사용하면 키에 해당하는 값이 제거된 후 반환된다

print(numberForName5["cs"]) // 200
print(numberForName5["mj"]) // nil

numberForName5["cs"] = 150
print(numberForName5["cs"]) // 150

numberForName5["max"] = 999 // max라는 키에 999값을 추가한다
print(numberForName5["max"]) // 999

print(numberForName5.removeValue(forKey: "esbae")) // 100
print(numberForName5.removeValue(forKey: "esbae")) // esbae키에 해당하는 값이 이미 삭제되어 없으므로 nil이 반환된다

// 키에 해당하는 값이 없는 경우 반환받을 기본값을 지정하는 방법
print(numberForName5["esbae", default: 0]) // 0
