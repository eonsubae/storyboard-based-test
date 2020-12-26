import UIKit

// 흐름 제어
// 스위프트의 if 구문의 조건식은 반드시 Bool타입이어야 한다
// 스위프트에서는 전통적인 C스타일의 for문을 삭제되었다
// do-while문은 repeat-while문으로 구현되어 있다

// for in 구문
/*
  for 임시 상수 in 시퀀스 {
    실행 코드
  }
*/

for i in 0...5 {
    
    if i.isMultiple(of: 2) {
        print(i)
        continue
    }
    
    print("\(i) == 홀수")
}
// 0
// 1 == 홀수
// 2
// 3 == 홀수
// 4
// 5 == 홀수

let helloSwift: String = "Hello Swift!"

// 문자열을 순환하기
for char in helloSwift {
    print(char)
}
// H
// e
// l
// l
// o
//
// S
// w
// i
// f
// t
// !

var result: Int = 1

// 시퀀스에 해당하는 값이 필요 없다면 _을 사용하면 된다
for _ in 1...3 {
    result *= 10
}

print("10의 3제곱은 \(result)입니다.") // 10의 3제곱은 1000입니다.

/* 기본 데이터 타입의 for in 반복 구문 사용 */
// 딕셔너리
let friends: [String: Int] = ["Jay": 35, "Joe": 29, "Jenny": 31]

for tuple in friends {
    print(tuple)
}
// (key: "Jay", value: 35)
// (key: "Joe", value: 29)
// (key: "Jenny", value: 31)

let address: [String: String] = ["도": "경기도", "시군구": "수원시 장안구", "동읍면": "이목동"]

for (key, value) in address {
    print("\(key) : \(value)")
}
// 동읍면 : 이목동
// 도 : 경기도
// 시군구 : 수원시 장안구

// 세트
let telNumbers: Set<String> = ["02", "031", "032"]

for tel in telNumbers {
    print(tel)
}
// 02
// 031
// 032

/* while구문 */
var names: [String] = ["Joker", "Jenny", "Nova", "Esbae"]

while names.isEmpty == false {
    print("Good bye \(names.removeFirst())")
}
// Good bye Joker
// Good bye Jenny
// Good bye Nova
// Good bye Esbae

/* repeat-while구문 */
var names2: [String] = ["Joker", "Jenny", "Nova", "Esbae"]

repeat {
    print("Good bye \(names2.removeFirst())")
} while names2.isEmpty == false
// Good bye Joker
// Good bye Jenny
// Good bye Nova
// Good bye Esbae

/* 구문 이름표 */
// 반복문이 중첩되었을 때 break, continue같은 키워드가 어떤 계층에 적용되어야 하는지
// 헷갈리는 경우가 많다. 이 때 구문 이름표로 반복문에 이름을 붙이면 쉽게 파악할 수 있다
var numbers: [Int] = [3, 2342, 6, 3252]

numbersLoop: for num in numbers {
    if num > 5 || num < 1 {
        continue numbersLoop
    }
    
    var count: Int = 0
    
    printLoop: while true {
        
        print(num)
        count += 1
        
        if count == num {
            break printLoop
        }
    }
    
    removeLoop: while true {
        if numbers.first != num {
            break removeLoop
        }
        numbers.removeFirst()
    }
}
// 3
// 3
// 3
