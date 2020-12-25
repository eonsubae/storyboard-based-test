import UIKit

// 열거형(Enum)
// 연관된 항목들을 묶어서 표현할 수 있는 타입
// 배열이나 딕셔너리 같은 타입과 다르게 프로그래머가 정의해 준 항목 값 외에는 추가/수정이 불가능하다

/* 열거형의 사용처*/
// 1. 제한된 선택지, 2. 정해진 값 외에는 입력받고 싶지 않을 때, 3. 예상된 입력값이 한정되어 있을 때
// ex1. 무선통신 방식: WiFi, 블루투스, LTE, 3G
// ex2. 학생: 초등학생, 중학생, 고등학생, 대학생, 대학원생
// ex3. 지역: 강원도, 경기도, 경상도, 전라도, 제주도, 충청도

// C언어의 열거형과 차이점
// C언어는 열거형의 각 항목값은 정수값으로 기본 지정되지만, 항목마다 스위프트에서는 고유의 값을 사용할 수 있다

// 열거형의 선언
enum School {
    case primary
    case elementary
    case middle
    case high
    case college
    case university
    case graduate
} // 각 항목은 그 자체로 고유의 값이다

// 항목마다 case를 써주는 것이 싫다면 생략할 수 있다
enum School2 {
    case primary, elementary, middle, high, college, university, graduate
}

// 열거형의 생성 및 값 변경
var highestEducationLevel: School = School.university
var highestEducationLevel2: School = .university // 위 코드와 같은 동작을 한다
highestEducationLevel2 = .graduate // 같은 타입인 School 열거형의 항목 안에서만 변경가능하다

// 열거형은 항목 그 자체로도 하나의 값이지만 원시 값(Raw Value)도 가질 수 있다
enum School3: String { // 원시 값을 가지기 위해서는 열거형의 이름 옆에 해당 원시 값의 타입을 기재해야 한다
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
} // 만약 일부 항목만 원시값을 기재하면 기재하지 않은 항목은 그 자체로 항목 이름을 원시값으로 갖게 된다

let highestEducationLevel3: School3 = School3.university
print("저의 최종학력은 \(highestEducationLevel3.rawValue) 졸업입니다.")
// 저의 최종학력은 대학교 졸업입니다.

enum WeekDays: Character {
    case mon = "월", tue = "화", wed = "수", thu = "목", fri = "금", sat = "토", sun = "일"
}

let today: WeekDays = WeekDays.fri
print("오늘은 \(today.rawValue)요일입니다.") // 오늘은 금요일입니다.

// 기재하지 않은 원시값을 자동처리
enum Numbers: Int {
    case zero
    case one
    case two
    case ten = 10
}

print("\(Numbers.zero.rawValue), \(Numbers.one.rawValue), \(Numbers.two.rawValue), \(Numbers.ten.rawValue)")
// 0, 1, 2, 10

// 원시값을 통한 열거형 초기화
// 잘못된 원시값을 입력한 경우 nil이 반환된다
let primary = School3(rawValue: "유치원") // primary
let graduate = School3(rawValue: "석박사") // nil

let one = Numbers(rawValue: 1) // one
let three = Numbers(rawValue: 3) // nil

// 연관값을 갖는 열거형
enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = MainDish.pasta(taste: "크림") // pasta(taste: "크림")
dinner = .pizza(dough: "치즈크러스트", topping: "불고기") // pizza(dough "치즈크러스트", topping "불고기")
dinner = .chicken(withSauce: true) // chicken(withSauce: true)
dinner = .rice // rice

// 만약 연관값이 한정적이라면 다음과 같이 기술하면 된다
enum PastaTaste {
    case cream, tomato
}

enum PizzaDough {
    case cheeseCrust, thin, original
}

enum PizzaTopping {
    case pepperoni, cheese, bacon
}

enum MainDish2 {
    case pasta(taste: PastaTaste)
    case pizza(dough: PizzaDough, topping: PizzaTopping)
    case chicken(withSauce: Bool)
    case rice
}

var dinner2: MainDish2 = MainDish2.pasta(taste: PastaTaste.tomato)
dinner2 = MainDish2.pizza(dough: PizzaDough.cheeseCrust, topping: PizzaTopping.bacon)

// 항목 순회
// 때로는 열거형에 포함된 모든 케이스를 알아야 할 때가 있다
// 이런 때에는 열거형의 이름 뒤에 : CaseIterable을 붙여준다
// 위 코드는 CaseIterable이라는 프로토콜을 따른다는 의미다
// CaseIterable프로토콜을 따르는 열거형은 allCases라는 프로퍼티로 모든 케이스의 컬렉션을 생성할 수 있다
enum School4: CaseIterable {
    case primary
    case elementary
    case middle
    case high
    case college
    case university
    case graduate
}

let allCases: [School4] = School4.allCases
print(allCases) // [School4.primary, ..., School4.graduate]

// 원시값을 갖는 열거형일 경우 원시값의 타입, CaseIterable순으로 적어주면 된다
enum School5: String, CaseIterable {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    @available(iOS, obsoleted: 12.0)
    case graduate = "대학원"
    
    static var allCases: [School5] {
        let all: [School5] = [.primary,
                              .elementary,
                              .middle,
                              .high,
                              .college,
                              .university]
        
        #if os(iOS)
        return all
        #else
        return all + [.graduate]
        #endif
    }
}

let allCases2: [School5] = School5.allCases
print(allCases2) // 실행환경에 따라 다른 결과 출력

// 연관 값을 갖는 열거형의 항목 순회
enum PastaTaste2: CaseIterable {
    case cream, tomato
}

enum PizzaDough2: CaseIterable {
    case cheeseCrust, thin, original
}

enum PizzaTopping2: CaseIterable {
    case pepperoni, cheese, bacon
}

enum MainDish3: CaseIterable {
    case pasta(taste: PastaTaste2)
    case pizza(dough: PizzaDough2, topping: PizzaTopping2)
    case chicken(withSauce: Bool)
    case rice
    
    static var allCases: [MainDish3] {
        return PastaTaste2.allCases.map(MainDish3.pasta)
            + PizzaDough2.allCases.reduce([]) { (result, dough) -> [MainDish3] in
                result + PizzaTopping2.allCases.map { (topping) -> MainDish3 in
                    MainDish3.pizza(dough: dough, topping: topping)
                }
            }
            + [true, false].map(MainDish3.chicken)
            + [MainDish3.rice]
    }
}

print(MainDish3.allCases.count) // 14
print(MainDish3.allCases) // 모든 경우의 연관 값을 갖는 케이스 컬렉션

// 순환 열거형
// 열거형 항목의 연관값이 열거형 자신의 값이고자 할 때 사용한다
// indirect 키워드로 순환 열거형임을 명시한다
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

//열거형 전체에 순환 열거형 명시
indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

// 순환 열거형의 사용
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let final = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

let result: Int = evaluate(final)
print("(5 + 4) * 2 = \(result)") // (5 + 4) * 2 = 18
