import UIKit

// 옵셔널
// 안전성을 담보하는 문법
// 값이 있을 수도, 없을 수도 있음을 나타내는 표현이다
// 구체적으로 말하자면 변수 혹은 상수의 값이 nil일 수도 있음을 의미(스위프트에서는 null을 nil로 표현한다)
// '해당 변수 또는 상수에는 값이 없을 수 있다. 즉, 변수 또는 상수가 nil일 수도 있으므로 사용에 주의하라'는 의미를 내포한다

/* 오류가 발생하는 nil 할당 */
// nil은 옵셔널로 선언된 곳에서만 할당 가능
// 옵셔널 변수는 데이터 타입 뒤에 ?를 붙여 표현한다
var myName: String? = "esbae" // 옵셔널 선언방법1
print(myName) // Optional("esbae")

myName = nil
print(myName) // nil

var myName2: Optional<String> = "esbae" // 옵셔널 선언방법2

/* switch를 통한 옵셔널 값의 확인 */
func checkOptionalValue(value optionalValue: Any?) {
    switch optionalValue {
    case .none:
        print("This Optional variable is nil")
    case .some(let value):
        print("Value is \(value)")
    }
}

var myName3: String? = "esbae"
checkOptionalValue(value: myName3) // Value is esbae

myName3 = nil
checkOptionalValue(value: myName3) // This Optional variable is nil

/* switch를 통한 옵셔널 값의 확인2 */
let numbers: [Int?] = [2, nil, -4, nil, 100]

for number in numbers {
    switch number {
    case .some(let value) where value < 0:
        print("Negative value!! \(value)")
    case .some(let value) where value > 10:
        print("Large value!! \(value)")
    case .some(let value):
        print("Value \(value)")
    case .none:
        print("nil")
    }
}
// Value 2
// nil
// Negative value!! -4
// nil
// Large value!! 100

/* 옵셔널 추출 */
// 옵셔널 값을 옵셔널이 아닌 값으로 추출하는 방법을 말한다

/* 옵셔널 강제 추출 */
// 가장 간단하지만 런타임 오류가 발생할 가능성이 가장 높기 때문에 가장 위험한 방법
// 또, 옵셔널을 만든 의미가 무색해지는 방법이다
// 옵셔널 값의 뒤에 !를 붙이면 강제로 값을 추출해낸다
// 만약 강제 추출 시 옵셔널에 값이 없으면(nil이라면) 런타임 오류가 발생
var myName4: String? = "esbae"

var esbae: String = myName4!

myName4 = nil
//esbae = myName4! // 런타임 오류

// 조건문을 이용해 보다 안전하게 처리
if myName4 != nil {
    print("My name is \(myName4!)")
} else {
    print("myName == nil")
} // myName == nil

/* 옵셔널 바인딩 */
// 위처럼 조건문으로 체크를 해서 처리하는 방식은 다른 프로그래밍 언어의 널체크 방식과 유사하다
// 그런데 위와 같은 방식은 옵셔널을 사용하는 의미가 무색해지므로 스위프트에서는 조금 더 안전하고 세련된 옵셔널 바인딩을 제공한다
// 만약 옵셔널에 값이 있다면 옵셔널에서 추출한 값을 일정 블록 안에서 사용할 수 있는 변수나 상수로 할당해서 사용할 수 있게 해준다
// if 또는 while 구문 등과 결합해서 사용할 수 있다
var myName5: String? = "esbae"

// 옵셔널 바인딩을 통한 임시 상수 할당
if let name = myName5 {
    print("My name is \(name)")
} else {
    print("myName == nil")
} // My name is esbae

// 옵셔널 바인딩을 통한 임시 변수 할당
if var name = myName5 {
    name = "wizplan" // 변수이므로 내부에서 변경 가능
    print("My name is \(name)")
} else {
    print("myName == nil")
} // My name is wizplan

/* 옵셔널 바인딩을 사용한 여러 개의 옵셔널 값의 추출 */
// ,를 사용해 바인딩 할 옵셔널을 나열하면 된다.
// 바인딩하려는 옵셔널 값 중 하나라도 없다면 해당 블록 내부의 명렴운은 실행되지 않는다.
var myName6: String? = "esbae"
var yourName: String? = nil

// friend에 바인딩이 되지 않으므로 실행되지 않는다
if let name = myName6, let friend = yourName {
    print("We are friend! \(name) & \(friend)")
}

yourName = "eric"

if let name = myName6, let friend = yourName {
    print("We are friend! \(name) & \(friend)")
} // We are friend! esbae & eric

/* 암시적 추출 옵셔널 */
// nil을 할당하고 싶지만, 매번 값을 추출하기 귀찮거나
// 로직상 nil로 인한 런타임 에러가 발생하지 않을 것 같다는 확신이 들 때
// nil을 할당해줄 수 있는 옵셔널이 아닌 변수나 상수가 있으면 유용하다
// 암시적 추출 옵셔널에는 변수 혹은 상수의 타입의 뒤에 !를 사용하면 된다
// 옵셔널이기 때문에 nil의 할당도 가능하지만 nil이 할당되어 있을 때 변수에 접근을 시도하면 런타임 에러가 발생한다
var myName7: String! = "esbae"
print(myName7!) // esbae
myName7 = nil

if let name = myName7 {
    print("My name is \(name)")
} else {
    print("myName == nil")
} // myName == nil

// myName7.isEmpty // 오류 발생
/*
  옵셔널을 사용할 때는 강제 추출이나 암시적 추출 옵셔널을 사용하기 보다
  옵셔널 바인딩, nil 병합 연산자, 옵셔널 체이닝을 사용하는 것이 안전하면서도
  스위프트의 지향점과도 부합한다
*/
