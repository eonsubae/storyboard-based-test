import UIKit

// 프로퍼티와 메서드
// 프로퍼티는 클래스, 구조체 또는 열거형 등에 관련된 값을 뜻한다
// 메서드는 특정 타입에 관련된 함수를 뜻한다

/* 프로퍼티 */
// 1. 저장 프로퍼티Stored property
// 인스턴스의 변수 또는 상수(구조체와 클래스만 가능)
// 2. 연산 프로퍼티Computed property
// 특정 연산을 실행한 결괏값(구조체와 클래스, 열거형 모두 가능)
// 3. 타입 프로퍼티Type property
// 인스턴스가 아닌 특정 타입에 사용되는 프로퍼티
// 4. 프로퍼티 감시자
// 프로퍼티의 값이 변할 때 변화에 따른 특정 작업을 실행(저장 프로퍼티에 적용 가능)

/* 저장 프로퍼티Stored property */
// var 키워드를 사용하면 변수 저장 프로퍼티, let 키워드를 사용하면 상수 저장 프로퍼티가 된다

/* 저장 프로퍼티의 선언 및 인스턴스 생성 */
struct CoordinatePoint {
    var x: Int
    var y: Int
}

// 구조체에는 기본적으로 저장 프로퍼티를 매개변수로 갖는 이니셜라이저가 있다
let esbaePoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

class Position {
    var point: CoordinatePoint
    let name: String
    
    init(name: String, currentPoint: CoordinatePoint) {
        self.name = name
        self.point = currentPoint
    }
}

let esbaePosition: Position = Position(name: "esbae", currentPoint: esbaePoint)

/* 저장 프로퍼티의 초깃값 지정 */
struct CoordinatePoint2 {
    var x: Int = 0
    var y: Int = 0
}

let esbaePoint2: CoordinatePoint2 = CoordinatePoint2()
let wizplanPoint: CoordinatePoint2 = CoordinatePoint2(x: 10, y: 5)

print("esbae's point : \(esbaePoint2.x), \(esbaePoint2.y)") // esbae's point : 0, 0
print("wizplan's point : \(wizplanPoint.x), \(wizplanPoint.y)") // wizplan's point : 10, 5

class Position2 {
    var point: CoordinatePoint2 = CoordinatePoint2()
    var name: String = "Unknown"
}

let esbaePosition2: Position2 = Position2()

esbaePosition2.point = esbaePoint2
esbaePosition2.name = "esbae"

/* 옵셔널 저장 프로퍼티 */
struct CoordinatePoint3 {
    var x: Int
    var y: Int
}

class Position3 {
    // 현재 사람의 위치를 모를 수도 있다 - 옵셔널
    var point: CoordinatePoint3?
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

// 이름은 알지만 위치는 모를 수도 있다
let esbaePosition3: Position3 = Position3(name: "esbae")

// 위치를 알게 되면 그 때 할당한다
esbaePosition3.point = CoordinatePoint3(x: 20, y: 10)

/* 지연 저장 프로퍼티 */
// 필요할 때 값이 할당되는 프로퍼티다
struct CoordinatePoint4 {
    var x: Int = 0
    var y: Int = 0
}

class Position4 {
    // 현재 사람의 위치를 모를 수도 있다 - 옵셔널
    lazy var point: CoordinatePoint4 = CoordinatePoint4()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let esbaePosition4: Position4 = Position4(name: "esbae")

print(esbaePosition4.point) // CoordinatePoint4(x: 0, y: 0)

/* 연산 프로퍼티 */
// 우선 연산 프로퍼티를 사용하지 않고 메서드로 접근자와 설정자를 구현한 코드
struct CoordinatePoint5 {
    var x: Int
    var y: Int
    
    // 접근자
    func oppositePoint() -> Self {
        return CoordinatePoint5(x: -x, y: -y)
    }
    
    // 설정자
    mutating func setOppositePoint(_ opposite: CoordinatePoint5) {
        x = -opposite.x
        y = -opposite.y
    }
}

var esbaePoint5: CoordinatePoint5 = CoordinatePoint5(x: 10, y: 20)

// 현재 좌표
print(esbaePoint5) // CoordinatePoint5(x: 10, y: 20)

// 대칭 좌표
print(esbaePoint5.oppositePoint()) // CoordinatePoint5(x: -10, y: -20)

// 대칭 좌표를 (15, 10)으로 설정
esbaePoint5.setOppositePoint(CoordinatePoint5(x: 15, y: 10))

// 현재 좌표는 -15, -10으로 설정된다
print(esbaePoint5) // CoordinatePoint5(x: -15, y: -10)

// 연산 프로퍼티를 사용하면 보다 간결하고 확실하게 표현이 가능하다
struct CoordinatePoint6 {
    var x: Int
    var y: Int
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint6 { // 연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint6(x: -x, y: -y)
        }
        
        // 설정자
        set(opposite) {
            x = -opposite.x
            y = -opposite.y
        }
    }
}

var esbaePoint6: CoordinatePoint6 = CoordinatePoint6(x: 10, y: 20)

// 현재 좌표
print(esbaePoint6) // CoordinatePoint6(x: 10, y: 20)

// 대칭 좌표
print(esbaePoint6.oppositePoint) // CoordinatePoint6(x: -10, y: -20)

// 대칭 좌표를 (15, 10)으로 설정
esbaePoint6.oppositePoint = CoordinatePoint6(x: 15, y: 10)

// 현재 좌표는 -15, -10으로 설정된다
print(esbaePoint6) // CoordinatePoint6(x: -15, y: -10)

/* 매개변수 이름을 생략한 설정자 */
struct CoordinatePoint7 {
    var x: Int
    var y: Int
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint7 { // 연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint7(x: -x, y: -y)
        }
        
        // 설정자
        set { // 매개변수를 생략하면 인자로 넘어온 값을 관용적으로 newValue로 사용할 수 있다
            x = -newValue.x
            y = -newValue.y
        }
    }
}

/* 읽기 전용 연산 프로퍼티 */
struct CoordinatePoint8 {
    var x: Int
    var y: Int
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint8 { // 연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint8(x: -x, y: -y)
        }
    }
}

/* 프로퍼티 감시자 */
// 프로퍼티의 값이 변경되기 직전에 호출하는 willSet과
// 프로퍼티의 값이 변경된 직후에 호출하는 didSet이 있다
// willSet에는 변경될 값이 인자로 전달되고(이름을 변경하지 않으면 관용적으로 newValue가 전달됨)
// didSet에는 변경전 값이 인자로 전달된다(이름을 변경하지 않으면 관용적으로 oldValue가 전달됨)
class Account {
    var credit: Int = 0 {
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
}

let myAccount: Account = Account()
myAccount.credit = 1000
// 잔액이 0원에서 1000원으로 변경될 예정입니다.
// 잔액이 0원에서 1000원으로 변경되었습니다.

/* 상속받은 연산 프로퍼티의 프로퍼티 감시자 구현 */
class Account2 {
    var credit: Int = 0 {
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
    
    var dollarValue: Double {
        get {
            return Double(credit)
        }
        
        set {
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경중입니다.")
        }
    }
}

class ForeignAccount: Account2 {
    override var dollarValue: Double {
        willSet {
            print("잔액이 \(dollarValue)달러에서 \(newValue)달러으로 변경될 예정입니다.")
        }
        
        didSet {
            print("잔액이 \(oldValue)달러에서 \(dollarValue)달러으로 변경되었습니다.")
        }
    }
}

let myAccount2: ForeignAccount = ForeignAccount()

myAccount2.credit = 1000
myAccount2.dollarValue = 2

/* 전역변수와 지역변수 */
// 연산 프로퍼티와 프로퍼티 감시자는 전역변수와 지역변수 모두에 사용가능하다
var wonInPocket: Int = 2000 {
    willSet {
        print("주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 예정입니다.")
    }
    
    didSet {
        print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
    }
}

var dollarInPocket: Double {
    get {
        return Double(wonInPocket) / 1000.0
    }
    
    set {
        wonInPocket = Int(newValue * 1000.0)
        print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
    }
}

dollarInPocket = 3.5

/* 타입 프로퍼티 */
class AClass {
    
    // 저장 타입 프로퍼티
    static var typeProperty: Int = 0
    
    // 저장 인스턴스 프로퍼티
    var instanceProperty: Int = 0 {
        didSet {
            Self.typeProperty = instanceProperty + 100
        }
    }
    
    // 연산 타입 프로퍼티
    static var typeComputedProperty: Int {
        get {
            return typeProperty
        }
        
        set {
            typeProperty = newValue
        }
    }
}

AClass.typeProperty = 123

let classInstance: AClass = AClass()
classInstance.instanceProperty = 100

print(AClass.typeProperty)
print(AClass.typeComputedProperty)

/* 타입 프로퍼티를 상수로 사용 */
class Account3 {
    static let dollarExchangeRate: Double = 1000.0
    
    var credit: Int = 0
    
    var dollarValue: Double {
        get {
            return Double(credit)
        }
        
        set {
            credit = Int(newValue * Account3.dollarExchangeRate)
            print("잔액을 \(newValue)달러로 변경중입니다.")
        }
    }
}

/*　키 경로keyPath */
// 프로퍼티의 위치만 참조하는 방법

/*
 \타입이름.경로.경로.경로
*/

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Stuff {
    var name: String
    var owner: Person
}

print(type(of: \Person.name)) // ReferenceWritableKeyPath<Person, String> 참조 타입인 경우
print(type(of: \Stuff.name)) // WritableKeyPath<Stuff, String> 값 타입인 경우

/* 기존의 키 경로에 하위 경로를 덧붙이기 */
let keyPath = \Stuff.owner
let nameKeyPath = keyPath.appending(path: \.name)

let esbae: Person = Person(name: "esbae")
let hana: Person = Person(name: "hana")
let macbook: Stuff = Stuff(name: "Macbook Pro", owner: esbae)
var iMac: Stuff = Stuff(name: "iMac", owner: esbae)
let iPhone: Stuff = Stuff(name: "iPhone", owner: hana)

let stuffNameKeyPath = \Stuff.name
let ownerkeyPath = \Stuff.owner

// \Stuff.owner.name과 같은 표현이 된다
let ownerNameKeyPath = ownerkeyPath.appending(path: \.name)

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 가져온다
print(macbook[keyPath: stuffNameKeyPath]) // Macbook Pro
print(iMac[keyPath: stuffNameKeyPath]) // iMac
print(iPhone[keyPath: stuffNameKeyPath]) // iPhone

print(macbook[keyPath: ownerNameKeyPath]) // esbae
print(iMac[keyPath: ownerNameKeyPath]) // esbae
print(iPhone[keyPath: ownerNameKeyPath]) // hana

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 변경한다
iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
iMac[keyPath: ownerkeyPath] = hana

print(iMac[keyPath: stuffNameKeyPath]) // iMac Pro
print(iMac[keyPath: ownerNameKeyPath]) // hana

// 상수로 지정한 값 타입과 읽기 전용 프로퍼티는 키 경로 서브스크립트로도 값을 바꿔줄 수 없다
// macbook[keyPath: stuffNameKeyPath] = "macbook pro touch bar" // 오류 발생
esbae[keyPath: \Person.name] = "bear" // 책에서는 에러라고 나오는데 실행이 된다
print(esbae[keyPath: \Person.name])
