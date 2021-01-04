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
