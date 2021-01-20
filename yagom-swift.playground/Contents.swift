/* 프로토콜 */

// 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 정의
// 구조체, 열거형, 클래스는 프로토콜을 채택Adopted해서 구현가능
// 어떤 프로토콜의 요구사항을 모두 따르는 타입을 '해당 프로토콜을 준수한다'고 표현한다

/*
  protocol 프로토콜 이름 {
     프로토콜 정의
  }
*/

// 프로토콜 채택
/*
  struct SomeStruct: AProtocol, AnotherProtocol {
    // 구조체 정의
  }
 
  class SomeClass: AProtocol, AnotherProtocol {
    // 클래스 정의
  }
 
  enum SomeEnum: AProtocol, AnotherProtocol {
    // 열거형 정의
  }
*/

// 만약 클래스가 다른 클래스를 상속받으면 상속받을 클래스 이름 다음에 프로토콜을 나열해준다
/*
  class SomeClass: SuperClass, AProtocol, AnotherProtocol {
    // 클래스 정의
  }
*/

/* 프로퍼티 요구 */
// 프로토콜은 프로퍼티나 메서드 등 필요한 기능의 구현을 강제할 수 있다
// 하지만 프로퍼티의 종류(연산, 저장 등)는 신경쓰지 않는다
// 다만 프로퍼티를 읽기 전용으로 할지, 읽기 쓰기가 모두 가능하게 할지는 프로토콜이 정해야 한다

/*
  protocol SomeProtocol {
      var settableProperty: String { get set } // 읽기 쓰기 모두 허용
      var notNeedToBeSettableProperty: String { get } // 읽기 전용
  }
 
  protocol AnotherProtocol {
      static var someTypeProperty: Int { get set } // 타입 프로퍼티
      static var anotherTypeProperty: Int { get } // 프로토콜에서는 class와 static을 구분하지 않고 static으로 선언하면 된다
  }
*/

protocol Sendable {
    var from: String { get }
    var to: String { get }
}

class Message: Sendable {
    var sender: String
    var from: String {
        return self.sender
    }
    
    var to: String
    
    init(sender: String, receiver: String) {
        self.sender = sender
        self.to = receiver
    }
}

class Mail: Sendable {
    var from: String
    var to: String
    
    init(sender: String, receiver: String) {
        self.from = sender
        self.to = receiver
    }
}

/* 메서드 요구 */
// 메서드의 이름, 매개변수, 반환 타입 등만 작성하며 가변 매개변수도 허용한다
// 매개변수 기본값은 지정할 수 없다

// 무언가를 수신받을 수 있는 기능
protocol Receiveable {
    func received(data: Any, from: Sendable2)
}

// 무언가를 발신할 수 있는 기능
protocol Sendable2 {
    var from: Sendable2 { get }
    var to: Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

// 수신, 발신이 가능한 Message 클래스
class Message2: Sendable2, Receiveable {
    // 발신은 발신 가능한 객체, 즉 Sendable2 프로토콜을 준수하는 타입의 인스턴스여야 한다
    var from: Sendable2 {
        return self
    }
    
    // 상대방은 수신 가능한 객체, 즉 Receiveable 프로토콜을 준수하는 타입의 인스턴스여야 한다
    var to: Receiveable?
    
    // 메시지를 발신한다
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no receiver")
            return
        }
        
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable2) {
        print("Message received \(data) from \(from)")
    }
    
    class func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable2 = instance as? Sendable2 {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 수신, 발신이 가능한 Mail 클래스
class Mail2: Sendable2, Receiveable {
    var from: Sendable2 {
        return self
    }
    
    var to: Receiveable?
    
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Mail has no receiver")
            return
        }
        
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable2) {
        print("Mail received \(data) from \(from)")
    }
    
    // static 메서드이므로 상속이 불가능하다
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable2 = instance as? Sendable2 {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 두 Message 인스턴스를 생성한다
let myPhoneMessage: Message2 = Message2()
let yourPhoneMessage: Message2 = Message2()

myPhoneMessage.send(data: "Hello") // Message has no receiver

myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello") // Message received Hello from Message2

let myMail: Mail2 = Mail2()
let yourMail: Mail2 = Mail2()

myMail.send(data: "Hi") // Mail has no receiver

myMail.to = yourMail
myMail.send(data: "Hi") // Mail received Hi from Mail2

myMail.to = myPhoneMessage
myMail.send(data: "Bye") // Message received Bye from Mail2

Message2.isSendableInstance("Hello") // false
Message2.isSendableInstance(myPhoneMessage) // true
Message2.isSendableInstance(yourPhoneMessage) // false

Mail2.isSendableInstance(myPhoneMessage) // true
Mail2.isSendableInstance(myMail) // true

/* 가변 메서드 요구 */
// 참조 타입인 클래스의 메서드 앞에는 mutating을 명시하지 않아도 인스턴스 내부의 값을 바꾸는 데 문제가 없지만
// 값 타입인 구조체와 열거형의 메서드가 인스턴스 내부의 값을 변경시킬 때는 mutating 키워드를 명시해야한다
// 물론 프로토콜에 mutating을 명시했다고 해도 클래스 구현에는 mutating 키워드를 쓰지 않아도 된다

protocol Resettable {
    mutating func reset()
}

class Person: Resettable {
    var name: String?
    var age: Int?
    
    func reset() {
        self.name = nil
        self.age = nil
    }
}

struct Point: Resettable {
    var x: Int = 0
    var y: Int = 0
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
}

enum Direction: Resettable {
    case east, west, south, north, unknown
    
    mutating func reset() {
        self = Direction.unknown
    }
}

/* 만약 Resettable 프로토콜에서 가변 메서드를 요구하지 않는다면
   값 타입의 인스턴스 내부 값을 변경하는 mutating 메서드는 구현이 불가능하다 */

/* 이니셜라이저 요구 */
protocol Named {
    var name: String { get }
    
    init(name: String)
}

struct Pet: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// 상속할 수 없는 구조체와 달리 클래스는 required 식별자를 붙인 요구 이니셜라이저로 구현해야 한다
class Person2: Named {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

// 만약 상속이 불가능한 final 클래스라면 required 식별자를 붙일 필요는 없다
final class Person3: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// 만약 상속받은 클래스에 프로토콜의 요구 이니셜라이저가 이미 구현되어 있다면
// required, override 키워드를 모두 붙여줘야 한다
class School {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class MiddleSchool: School, Named {
    required override convenience init(name: String) {
        self.init(name: name)
    }
}

/* 실패 가능한 이니셜라이저 요구 */
// 실패 가능한 이니셜라이저를 가진 프로토콜을 따르는 경우
// 실패 가능한 이니셜라이저로 구현해도
// 일반적인 이니셜라이저로 구현해도 상관없다

protocol NamedO {
    var name: String { get }
    
    init?(name: String)
}

struct AnimalO: NamedO {
    var name: String
    
    init!(name: String) {
        self.name = name
    }
}

struct PetO: NamedO {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class PersonO: NamedO {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class SchoolO: NamedO {
    var name: String
    
    required init?(name: String) {
        self.name = name
    }
}

/* 프로토콜 변수와 상수 */
// 프로토콜 이름을 타입으로 갖는 변수 또는 상수에는 그 프로토콜을 준수하는 타입의 어떤 인스턴스라도 할당할 수 있다
var someNamed: NamedO = AnimalO(name: "Animal")
someNamed = PetO(name: "Pet")
someNamed = PersonO(name: "Person")
someNamed = SchoolO(name: "School")!

/* 프로토콜의 상속 */
// 프로토콜은 하나 이상의 프로토콜을 상속받아 더 많은 요구사항을 추가할 수 있다

protocol Readable {
    func read()
}

protocol Writeable {
    func write()
}

protocol ReadSpeakable: Readable {
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}

class SomeClassRWS: ReadWriteSpeakable {
    func read() {
        print("Read")
    }
    
    func write() {
        print("Write")
    }
    
    func speak() {
        print("Speak")
    }
}

/* 클래스 전용 프로토콜 만들기 */
// 프로토콜의 상속 리스트에 class를 추가하면 클래스 타입에만 채택될 수 있다

protocol ClassOnlyProtocol: class, Readable, Writeable {
    // 추가 요구사항
}

class SomeClassCO: ClassOnlyProtocol {
    func read() {}
    func write() {}
}

/* 프로토콜 조합 */
// 매개변수에 여러 프로토콜의 준수할 것을 요구하려면 &로 복수의 프로토콜을 연결시키면 된다

protocol NamedC {
    var name: String { get }
}

protocol AgedC {
    var age: Int { get }
}

struct PersonC: NamedC, AgedC {
    var name: String
    var age: Int
}

class CarC: NamedC {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class TruckC: CarC, AgedC {
    var age: Int
    
    init(name: String, age: Int) {
        self.age = age
        super.init(name: name)
    }
}

func celebrateBirthday(to celebrator: NamedC & AgedC) {
    print("Happy birthday \(celebrator.name)!! Now you are \(celebrator.age)")
}

let esbae: PersonC = PersonC(name: "esbae", age: 31)
celebrateBirthday(to: esbae)

let myCar: CarC = CarC(name: "BB")
//celebrateBirthday(to: myCar) // Aged를 충족시키지 못해 에러 발생

//var someVar: CarC & TruckC & AgedC // 클래스 & 프로토콜 조합에서 클래스 타입은 한 타입만 조합 가능하므로 에러 발생

var someVar: CarC & AgedC // CarC 클래스의 인스턴스 역할을 수행함과 동시에 AgedC 프로토콜을 준수하는 인스턴스만 할당 가능

someVar = TruckC(name: "Truck", age: 5)

/* 타입캐스팅으로 대상이 프로토콜을 준수하는지 확인하거나 캐스팅하기 */
print(esbae is NamedC)
print(esbae is AgedC)

print(myCar is NamedC)
print(myCar is AgedC)

if let castedInstance: NamedC = esbae as? NamedC {
    print("\(castedInstance) is NamedC")
}

if let castedInstance: AgedC = esbae as? AgedC {
    print("\(castedInstance) is AgedC")
}

if let castedInstance: NamedC = myCar as? NamedC {
    print("\(castedInstance) is Named")
}

if let castedInstance: AgedC = myCar as? AgedC {
    print("\(castedInstance) is AgedC")
}

/* 선택적 요구사항 지정 */
// 선택적 요구사항을 정의하고 싶은 프로토콜은 objc 속성이 부여된 프로토콜이어야 한다
// 선택적 요구사항은 optional 식별자를 요구사항의 정의 앞에 붙여주면 된다
// 만약 메서드나 프로퍼티를 선택적 요구사항으로 만들면 그 요구사항의 타입은 자동적으로 옵셔널이 된다
// 매개변수나 반환 타입이 옵셔널이 된 것이 아니라 메서드 자체의 타입이 옵셔널이 된 것이다
// ex. (Int) -> String 타입의 메서드라면 ((Int) -> String)? 타입이 되는 것이다

import Foundation

@objc protocol Moveable {
    func walk()
    @objc optional func fly()
}

class Tiger: NSObject, Moveable {
    func walk() {
        print("Tiger walks")
    }
}

class Bird: NSObject, Moveable {
    func walk() {
        print("Bird walks")
    }
    
    func fly() {
        print("Bird flys")
    }
}

let tiger: Tiger = Tiger()
let bird: Bird = Bird()

tiger.walk()
bird.walk()
bird.fly()

var moveableInstance: Moveable = tiger
moveableInstance.fly?() // 응답 없음

moveableInstance = bird
moveableInstance.fly?() // Bird flys
