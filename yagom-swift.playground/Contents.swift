import UIKit

// 인스턴스의 생성과 소멸

/* 클래스, 구조체, 열거형의 기본적 형태의 이니셜라이저 */
// 이니셜라이저를 정의하면 초기화 과정을 직접 구현할 수 있다
// 그렇게 구현된 이니셜라이저는 새로운 인스턴스를 생성할 수 있는 특별한 메서드가 된다
// 이니셜라이저는 func 키워드를 사용하지 않고 오로지 init 키워드만 사용한다

class SomeClass {
    init() {
        /* 초기화 코드 */
    }
}

struct SomeStruct {
    init() {
        /* 초기화 코드 */
    }
}

enum SomeEnum {
    case someCase
    
    init() {
        /* 초기화 코드 */
        self = .someCase // 열거형은 초기화할 때 반드시 case 중 하나가 되어야 한다
    }
}

/* 프로퍼티 기본값 */
// 구조체, 클래스의 인스턴스는 처음 생성할 때
// 옵셔널 저장 프로퍼티를 제외한 모든 프로퍼티에 적절한 초기값이 필요하다
// 그런데 프로퍼티 기본값을 할당하면 이니셜라이저에서 따로 초깃값을 할당하지 않아도 프로퍼티 기본값으로 저장 프로퍼티의 값이 초기화된다
struct Area {
    var squareMeter: Double
    
    init() {
        squareMeter = 0.0
    }
}

let room: Area = Area()
print(room.squareMeter) // 0.0

/* 이니셜라이저가 아닌 프로퍼티 정의시 기본값을 할당하는 방식 */
struct Area2 {
    var squareMeter: Double = 0.0
}

let room2: Area2 = Area2()
print(room2.squareMeter) // 0.0

/* 이니셜라이저 매개변수 */
struct Area3 {
    var squareMeter: Double
    
    init(fromPy py: Double) {
        squareMeter = py * 3.3058
    }
    
    init(fromSqureMeter squareMeter: Double) {
        self.squareMeter = squareMeter
    }
    
    init(value: Double) {
        squareMeter = value
    }
    
    init(_ value: Double) {
        squareMeter = value
    }
}

let roomOne: Area3 = Area3(fromPy: 15.0)
print(roomOne.squareMeter) // 49.587

let roomTwo: Area3 = Area3(fromSqureMeter: 33.06)
print(roomTwo.squareMeter) // 33.06

let roomThree: Area3 = Area3(value: 30.0)
let roomFour: Area3 = Area3(55.0)

/* 옵셔널 프로퍼티 타입 */
// 인스턴스가 사용되는 동안에 꼭 값을 갖지 않아도 되는 저장 프로퍼티는 옵셔널로 만들면 된다
// 옵셔널로 선언한 저장 프로퍼티는 초기화 과정에서 값을 할당해 주지 않으면 자동으로 nil이 할당된다
class Person {
    var name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let esbae: Person = Person(name: "esbae")
print(esbae.name) // esbae
print(esbae.age) // nil

esbae.age = 99
print(esbae.age!) // 99

esbae.name = "Eric"
print(esbae.name) // Eric

/* 상수 프로퍼티 */
// 상수로 선언된 프로퍼티는 인스턴스를 초기화하는 과정에서만 값을 할당할 수 있다
class Person2 {
    let name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let esbae2: Person2 = Person2(name: "esbae")
// esbae2.name = "Eric" // 상수 저장 프로퍼티의 값을 변경하려 하면 에러가 발생

/* 기본 이니셜라이저 */
// 사용자 정의 이니셜라이저를 구현해주지 않으면
// 클래스나 구조체는 모든 프로퍼티에 기본값이 할당되어있다고 전제하에 기본 이니셜라이저를 실행한다
// 기본 이니셜라이저는 프로퍼티 기본값으로 프로퍼티를 초기화해 인스턴스를 생성한다

/* 멤버와이즈 이니셜라이저 */
// 프로퍼티에 기본값을 할당해주지 않으면 이니셜라이저에서 초깃값을 설정해야 한다
// 그런데 프로퍼티가 추가될 때마다 이니셜라이저를 추가하거나 변경하는 것이 번거로울 때
// 구조체는 멤버와이즈 이니셜라이저를 사용하여 프로퍼티에 이름을 값으로 지정해준다
struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

let point: Point = Point(x: 0, y: 0)
let size: Size = Size(width: 50.0, height: 50.0)

// 구조체의 저장 프로퍼티에 기본값이 있는 경우
// 필요한 매개변수만 사용하여 초기화할 수도 있다
let somePoint: Point = Point()
let someSize: Size = Size(width: 50)
let anotherPoint: Point = Point(y: 100)

/* 초기화 위임 */
// 값 타입인 구조체와 열거형은 코드의 중복을 피하기 위해
// 이니셜라이저가 다른 이니셜라이저에게 일부 초기화를 위임하는 코드를 구현할 수 있다
// self.init을 사용해 다른 이니셜라이저를 호출할 수 있다
// 클래스는 초기화위임이 불가능하다
enum Student {
    case elementary, middle, high
    case none

    init() {
        self = .none
    }
    
    init(koreanAge: Int) { // 첫 번쨰 사용자 정의 이니셜라이저
        switch koreanAge {
        case 8...13:
            self = .elementary
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            self = .none
        }
    }
    
    init(bornAt: Int, currentYear: Int) { // 두 번째 사용자 정의 이니셜라이저
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}

var younger: Student = Student(koreanAge: 16)
print(younger) // middle

younger = Student(bornAt: 1998, currentYear: 2016)
print(younger) // high

/* 실패 가능한 이니셜라이저 */
// 이니셜라이저로 초기화할 때 전달인자가 잘못된 값이면 에러가 발생할 수 있다
// 이렇게 실패가능성을 염두에 둔 이니셜라이저를 사용할 수 있다
// 실패시 nil을 반환해준다. 따라서 옵셔널이 반환타입이다
// init이 아닌 init?으로 이니셜라이저를 선언해줘야 한다
class Person3 {
    let name: String
    var age: Int?
    
    init?(name: String) {
        
        if name.isEmpty {
            return nil
        }
        
        self.name = name
    }
    
    init?(name: String, age: Int) {
        if name.isEmpty || age < 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}

let esbae3: Person3? = Person3(name: "esbae", age: 99)

if let person: Person3 = esbae3 {
    print(person.name)
} else {
    print("Person wasn't initialized")
} // esbae

let chope: Person3? = Person3(name: "chope", age: -10)

if let person: Person3 = chope {
    print(person.name)
} else {
    print("Person wasn't initialized")
} // Person wasn't initialized

let eric: Person3? = Person3(name: "", age: 30)

if let person: Person3 = eric {
    print(person.name)
} else {
    print("Person wasn't initialized")
} // Person wasn't initialized

/* 열거형의 실패 가능한 이니셜라이저 */
enum Student2: String {
    case elementary = "초등학생", middle = "중학생", high = "고등학생"
    
    init?(koreanAge: Int) {
        switch koreanAge {
        case 8...13:
            self = .elementary
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            return nil
        }
    }
    
    init?(bornAt: Int, currentYear: Int) {
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}

var younger2: Student2? = Student2(koreanAge: 20)
print(younger2) // nil

younger2 = Student2(bornAt: 2020, currentYear: 2016)
print(younger2) // nil

younger2 = Student2(rawValue: "대학생")
print(younger2) // nil

younger2 = Student2(rawValue: "고등학생")
print(younger2!) // high

/* 함수를 사용한 프로퍼티 기본값 설정 */
// 사용자 정의 연산으로 저장 프로퍼티 기본값을 설정하려 한다면
// 클로저나 함수를 사용하여 프로퍼티 기본값을 제공할 수 있다

/* 클로저를 통한 프로퍼티 기본값 설정 */
/*
class SomeClass {
    let someProperty: SomeType = {
        // 반환되는 값의 타입은 SomeType과 같은 타입이어야 한다
        return someValue
    }()
}
*/
struct Student3 {
    var name: String?
    var age: Int?
}

class SchoolClass {
    var students: [Student3] = {
        var arr: [Student3] = [Student3]()
        
        for num in 1...15 {
            var student: Student3 = Student3(name: nil, age: num)
            arr.append(student)
        }
        
        return arr
    }()
}

let myClass: SchoolClass = SchoolClass()
print(myClass.students.count) // 15

/* 인스턴스 소멸 */
// 디이니셜라이저를 구현하면 인스턴스가 소멸되기 직전에 호출되어 원하는 정리 작업을 구현할 수 있다
// deinit 키워드를 사용한다
// 디이니셜라이저는 클래스의 인스턴스에만 구현이 가능하다
// 클래스에서 단 하나의 디이니셜라이저만 구현할 수 있다
class SomeClass2 {
    deinit {
        print("Instance will be deallocated immediately")
    }
}

var instance: SomeClass2? = SomeClass2()
instance = nil // Instance will be deallocated immediately

class FileManager {
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func openFile() {
        print("Open File: \(self.fileName)")
    }
    
    func modifyFile() {
        print("Modify File: \(self.fileName)")
    }
    
    func writeFile() {
        print("Write FIle: \(self.fileName)")
    }
    
    func closeFile() {
        print("Close File: \(self.fileName)")
    }
    
    deinit {
        print("Deinit instance")
        self.writeFile()
        self.closeFile()
    }
}

var fileManager: FileManager? = FileManager(fileName: "abc.txt")

if let manager: FileManager = fileManager {
    manager.openFile() // Open File: abc.txt
    manager.modifyFile() // Modify File: abc.txt
}

fileManager = nil
// Deinit instance
// Write FIle: abc.txt
// Close File: abc.txt
