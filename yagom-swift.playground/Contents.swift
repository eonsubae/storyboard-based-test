import UIKit

// 컬렉션(Array, Dictionary, Set)
// 튜플 이외에도 데이터를 묶어서 저장하고 관리할 수 있는 타입인 컬렉션 타입이 있다

// Set
// 같은 타입의 데이터를 순서 없이 하나의 묶음으로 저장하는 컬렉션
// 순서가 중요하지 않거나 각 요소가 유일한 값이어야 하는 경우에 사용

// 세트의 선언과 생성
// 세트는 배열과 달리 축약형이 없다
var names: Set<String> = Set<String>() // 빈 세트 생성
var names2: Set<String> = [] // 빈 세트 생성

// Array와 마찬가지로 대괄호를 사용
// 타입 추론시에는 컴파일러가 Set이 아닌 Array로 지정하므로 주의하자
var names3: Set<String> = ["esbae", "cs", "yh", "esbae"]

print(names3.isEmpty) // false
print(names3.count) // 3

names3.insert("jenny")
print(names3.count) // 4
print(names3.remove("cs")) // cs
print(names3.remove("john")) // nil

/* 집합연산 */
let englishClassStudents: Set<String> = ["john", "cs", "esbae"]
let koreanClassStudents: Set<String> = ["jenny", "esbae", "cs", "hana", "ms"]

// 교집합
let intersectSet: Set<String> = englishClassStudents.intersection(koreanClassStudents) // {"esbae", "cs"}

// 여집합
let symmetricDiffSet: Set<String> = englishClassStudents.symmetricDifference(koreanClassStudents) // {"john", "jenny", "hana", "ms"}

// 합집합
let unionSet: Set<String> = englishClassStudents.union(koreanClassStudents) // {"john", "cs", "esbae", "jenny", "hana", "ms"}

// 차집합
let subtractSet: Set<String> = englishClassStudents.subtracting(koreanClassStudents) // {"john"}

print(unionSet.sorted()) // ["cs", "esbae", "hana", "jenny", "john", "ms"]

/* 포함관계 연산 */
let bird: Set<String> = ["비둘기", "닭", "기러기"]
let mammal: Set<String> = ["사자", "호랑이", "곰"]
let animal: Set<String> = bird.union(mammal) // bird와 mammal의 합집합

print(bird.isDisjoint(with: mammal)) // 서로 배타적인지 true
print(bird.isSubset(of: animal)) // 새가 동물의 부분집합인가? true
print(animal.isSuperset(of: mammal)) // 동물은 포유류의 전체집합인가? true
print(animal.isSuperset(of: bird)) // 동물은 새의 전체집합인가? true
