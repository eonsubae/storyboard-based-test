import UIKit

// 구조체와 클래스
// 스위프트에서 구조체의 인스턴스는 값 타입이고
// 클래스의 인스턴스는 참조 타입이다
// 소스코드 파일 하나에 여러 개의 구조체 및 클래스의 구현이 가능하며
// 구조체 내부에 구조체를, 클래스 내부에 클래스처럼 중첩 타입을 정의할 수 있다

/* 구조체 */
// 구조체는 struct 키워드로 정의한다

/*
  struct 구조체 이름 {
    프로퍼티와 메서드들
  }
*/
struct BasicInformation {
    var name: String
    var age: Int
}

/* 구조체 인스턴스의 생성 및 초기화 */
var esbaeInfo: BasicInformation = BasicInformation(name: "esbae", age: 30)
esbaeInfo.name = "Seba"
esbaeInfo.age = 17

// 상수로 인스턴스를 선언하면 프로퍼티의 변경이 불가능하다
let esbaeInfo2: BasicInformation = BasicInformation(name: "esbae", age: 30) // 상수 인스턴스 선언
// esbaeInfo2.name = "Seba" // 변경 불가
// esbaeInfo2.age = 17 // 변경 불가

/* 클래스 */

/* 클래스의 정의 */
/*
 class 클래스 이름: 부모클래스 이름 {
   프로퍼티와 메서드들
 }
*/
class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

/* 클래스 인스턴스의 생성 및 초기화 */
var esbae: Person = Person()
esbae.height = 181.5
esbae.weight = 75.0

// 구조체와 달리 클래스는 인스턴스를 상수로 선언해도 프로퍼티를 변경할 수 있다
let jenny: Person = Person()
jenny.height = 181.5
jenny.weight = 75.0

/* 클래스 인스턴스의 소멸 */
// deinit 메서드로 인스턴스가 메모리에서 해제되기 직전에 처리할 코드를 넣어줄 수 있다
class Person2 {
    var height: Float = 0.0
    var weight: Float = 0.0
    
    deinit {
        print("Person2 클래스의 인스턴스가 소멸됩니다.")
    }
}

var esbae2: Person2? = Person2()
esbae2 = nil // Person2 클래스의 인스턴스가 소멸됩니다.

/* 구조체와 클래스의 차이 */
// 구조체는 상속이 불가능하다
// 타입캐스팅은 클래스의 인스턴스에만 허용된다
// 디이니셜라이저는 클래스의 인스턴스에만 활용할 수 있다
// 참조 횟수 계산Reference Counting은 클래스의 인스턴스에만 적용된다

/* 값 타입과 참조 타입 */
// 값 타입은 함수의 전달인자로 값을 넘기면 복사된 값이 전달된다
// 참조 타입은 복사하지 않고 참조가 바로 전달된다
var esbaeInfo3: BasicInformation = BasicInformation(name: "esbae", age: 30)
esbaeInfo3.age = 100

// esbaeInfo3의 값을 복사해 할당한다
var friendInfo: BasicInformation = esbaeInfo3

print("esbae's age : \(esbaeInfo3.age)") // esbae's age : 100
print("friend's age : \(friendInfo.age)") // friend's age : 100


friendInfo.age = 999

print("esbae's age : \(esbaeInfo3.age)") // esbae's age : 100
print("friend's age : \(friendInfo.age)") // friend's age : 999

var esbae3: Person = Person()
var friend: Person = esbae3

print("esbae's height : \(esbae3.height)") // esbae's height : 0.0
print("friend's height : \(friend.height)") // friend's height : 0.0

friend.height = 181.5
print("esbae's height : \(esbae3.height)") // esbae's height : 181.5
print("friend's height : \(friend.height)") // friend's height : 181.5

func changeBasicInfo(_ info: BasicInformation) {
    var copiedInfo: BasicInformation = info
    copiedInfo.age = 1
}

func changePersonInfo(_ info: Person) {
    info.height = 155.3
}

changeBasicInfo(esbaeInfo3)
print(esbaeInfo3.age) // 100

changePersonInfo(esbae3)
print(esbae3.height) // 155.3

/* 식별 연산자 */
let b: Person = Person()
let f: Person = b
let af: Person = Person()

print(b === f) // true
print(b === af) // false
print(f !== af) // true

/* 애플 가이드라인이 권고하는 구조체의 사용처 */
// 연관된 간단한 값의 집합을 캡슐화하는 것만이 목적일 때
// 캡슐화한 값을 참조하는 것보다 복사하는 것이 합당할 때
// 구조체에 저장된 프로퍼티가 값 타입이며 참조하는 것보다 복사하는 것이 합당할 때
// 다른 타입으로부터 상속받거나 자신을 상속할 필요가 없을 때
