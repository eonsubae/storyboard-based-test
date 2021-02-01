/* ARC(Automatic Reference Counting) */
// 자동으로 메모리를 관리해주는 방식
// 더 이상 필요하지 않은 인스턴스의 메모리를 관리해준다
// 이는 참조 타입인 클래스에만 적용된다(구조체, 열거형은 적용 안됨)

/* 가비지 컬렉션과의 차이 */
//                    ARC                            가비지 컬렉션
// 참조 카운팅 시점     컴파일 시                          프로그램 동작 중
//      장점       1.컴파일 당시 해제 시점이 정해져 있어     1.상호 참조 등 복잡한 경우에도
//                언제 해제될지 예측 가능                  인스턴스를 해제할 가능성이 더 높다
//                2.메모리 관리를 위한 시스템 자원을       2.특별히 규칙에 신경 쓸 필요가 없다
//                  추가할 필요가 없다

//      단점       ARC의 규칙을 모르면 인스턴스가          1.프로그램 동작 외에 메모리 감시를 위한
//                메모리에서 영원히 해제되지 않을 수 있다      추가 자원이 필요하므로 성능 저하가 발생할 수 있다
//                                                 2.명확한 규칙이 없어 언제 해제될지 예측이 어렵다

// 스위프트에서는 ARC를 사용한다
// 따라서 클래스의 인스턴스가 생성될 때마다 해당 인스턴스의 정보를 저장하기 위한
// 별도의 메모리 공간을 할당한다. 이 공간에는 인스턴스의 타입 정보, 값 등이 저장된다.
// 더 이상 인스턴스가 필요없어지면 ARC가 메모리에서 인스턴스를 해제한다
// 만약 지속적으로 필요한 인스턴스임에도 해제가 된다면 오류의 원인이 되므로
// 필요한 인스턴스가 해제되지 않기 위한 명분을 ARC에 제공해야 한다
// 명분을 부여하는 것에는 몇 가지 규칙이 있다

/* 강한 참조Strong Reference */
// 인스턴스는 참조 횟수가 0이 되면 메모리에서 해제된다
// 강한참조로 다른 인스턴스의 프로퍼티, 변수, 상수 등에 할당하면 참조 횟수가 1 증가한다
// 반대로 위의 대상들에 nil을 할당하면 참조 횟수가 1 감소한다

/* 강한 참조 적용 방법 */
// 참조의 기본은 강한 참조이므로 별도의 식별자를 명시하지 않으면 적용된다
class Person {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "esbae") // 인스턴스의 참조 횟수 : 1
reference2 = reference1 // 인스턴스의 참조 횟수 : 2
reference3 = reference1 // 인스턴스의 참조 횟수 : 3

reference3 = nil // 인스턴스의 참조 횟수 : 2
reference2 = nil // 인스턴스의 참조 횟수 : 1
reference1 = nil // 인스턴스의 참조 횟수 : 0

func foo() {
    let esbae: Person = Person(name: "esbae") // 인스턴스의 참조 횟수 : 1
    
    // 함수 종료 시점
    // 인스턴스의 참조 횟수 : 0
}
foo()

/* 강한참조 순환 문제 */
// 복합적으로 강한참조가 일어나면 문제가 발생할 수 있다
// 대표적으로 인스턴스끼리 서로가 서로를 참조하는 상황이 있다
// 이를 강한참조 순환Strong Reference Cycle이라고 한다
class PersonB {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var room: Room?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Room {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    var host: PersonB?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var es: PersonB? = PersonB(name: "es") // PersonB 인스턴스의 참조 횟수 : 1
var room: Room? = Room(number: "505") // Room 인스턴스의 참조 횟수 : 1

room?.host = es // PersonB 인스턴스의 참조 횟수 : 2
es?.room = room // Room 인스턴스의 참조 횟수 : 2

es = nil // Person 인스턴스의 참조 횟수 : 1
room = nil  // Room 인스턴스의 참조 횟수 : 1
// 위와 같이 인스턴스를 해제하고 나면
// es의 프로퍼티인 Room 인스턴스와 room의 프로퍼티인 PersonB의 인스턴스를 해제할 방법은 더 이상 없다
// ARC의 규칙대로 참조 횟수가 0이되지 않으면 메모리에서 해제되지 않는다
// deinitializer도 호출되지 않는 것을 확인할 수 있다

/* 강한참조 순환 문제를 수동으로 해결 */
// 앞서 es = nil, room = nil 이전에 es?.room = nil, room?.host = nil을 했다면
// 참조 횟수는 0이 되어 둘 다 정상적으로 메모리에서 해제될 것이다
// 하지만 이런 방법은 실수할 가능성이 높고, 해제해야 할 프로퍼티가 너무 많을 경우 비효율적이다
// 이를 해결하는 데에 약한참조와 미소유참조가 대안이 될 수 있다

/* 약한참조Weak Reference */
// 자신이 참조하는 인스턴스의 참조 횟수를 증가시키지 않는 방법
// 참조 타입의 프로퍼티나 변수의 선언 앞에 weak 키워드를 붙이면 된다
// 약한참조를 쓰면 자신이 참조하는 인스턴스가 메모리에서 해제될 가능성을 생각해야 한다
// 자신이 참조 횟수를 증가시키지 않으므로, 다른 프로퍼티나 변수에서 횟수를 0으로 감소시키면
// 자신이 참조하던 인스턴스가 해제되기 때문이다
class RoomWeak {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    weak var host: PersonB?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var esb: PersonB? = PersonB(name: "esb") // PersonB 인스턴스의 참조 횟수 : 1
var roomWeak: Room? = Room(number: "505") // Room 인스턴스의 참조 횟수 : 1

room?.host = es // PersonB 인스턴스의 참조 횟수 : 1 (weak이므로 증가x)
es?.room = room // Room 인스턴스의 참조 횟수 : 2

es = nil // PersonB 인스턴스의 참조 횟수 : 0
room = nil  // Room 인스턴스의 참조 횟수 : 1
// Room 505 is being deinitialized

/* 미소유참조Unknown Reference */
// 자신이 참조하는 인스턴스가 항상 메모리에 있을 것이라고 전제하고 동작한다
// 만약 참조하는 인스턴스가 메모리에서 해제도더라도 nil을 자동으로 할당해주지 않는다
// 따라서 옵셔널일 필요가 없다. 그렇지만 메모리에서 해제된 인스턴스에 접근하려하면 런타임 오류로 프로세스가 강제종료된다
// 따라서 참조하는 동안 메모리에서 해제되지 않는다는 확신이 있을 때만 사용한다
// unowned 키워드를 쓰면 변수(상수)나 프로퍼티는 자신이 참조하는 인스턴스를 미소유참조한다

/* 미소유 참조의 사용법 */
// 사람과 신용카드의 관계를 생각하면 쉽다
// 사람이 신용카드를 소지하지 않을 수는 있지만, 신용카드는 명의자가 반드시 있어야만 한다
class PersonC {
    let name: String
    
    var card: CreditCard? // 사람은 신용카드가 없어도 된다
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt
    unowned let owner: PersonC // 카드는 소유자가 반드시 있어야 한다
    
    init(number: UInt, owner: PersonC) {
        self.number = number
        self.owner = owner
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var js: PersonC? = PersonC(name: "JS") // PersonC 인스턴스의 참조 횟수 : 1

if let person: PersonC = js {
    person.card = CreditCard(number: 1004, owner: person) // CreditCard 인스턴스의 참조 횟수 : 1
    // PersonC 인스턴스의 참조 횟수 : 1, 미소유참조된 인스턴스는 참조 횟수가 증가하지 않는다
}

js = nil // PersonC 인스턴스의 참조 횟수 : 0
// CreditCard 인스턴스의 참조 횟수 : 0
// JS is being deinitialized
// Card #1004 is being deinitialized

/* 미소유참조와 암시적 추출 옵셔널 프로퍼티 */
// 서로 참조해야 하는 프로퍼티에 값이 꼭 있어야 하면서도
// 한번 초기화하면 그 이후에는 nil을 할당할 수 없는 조건을 갖추어야 하는 경우
class Company {
    let name: String
    
    // 암시적 추출 옵셔널 프로퍼티(강한참조)
    var ceo: CEO!
    
    init(name: String, ceoName: String) {
        self.name = name
        self.ceo = CEO(name: ceoName, company: self)
    }
    
    func introduce() {
        print("\(name)의 CEO는 \(ceo.name)입니다.")
    }
}

class CEO {
    let name: String
    
    // 미소유참조 상수 프로퍼티(미소유참조)
    unowned let company: Company
    
    init(name: String, company: Company) {
        self.name = name
        self.company = company
    }
    
    func introduce() {
        print("\(name)는 \(company.name)의 CEO입니다.")
    }
}

let company: Company = Company(name: "테슬라", ceoName: "머스크")
company.introduce() // 테슬라의 CEO는 머스크입니다.
company.ceo.introduce() // 머스크는 테슬라의 CEO입니다.

/* 클로저의 강한참조 순환 */
// 강한참조 순환 문제는 클로저가 인스턴스의 프로퍼티일 때, 클로저의 값 획득 특성 때문에도 발생한다
// 예를 들어, self.someProperty처럼 인스턴스의 프로퍼티에 접근할 때, 클로저가 self를 획득하므로 강한참조 순환이 발생한다
// 이는 클로저의 획득 목록을 통해 해결할 수 있다
class PersonD {
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = {
        var introduction: String = "My name is \(self.name)"
        
        guard let hobby = self.hobby else {
            return introduction
        }
        
        introduction += " "
        introduction += "My hobby is \(hobby)"
        
        return introduction
    }
    
    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var bs: PersonD? = PersonD(name: "bs", hobby: "eating")
print(bs?.introduce()) // My name is bs. My hobby is eating.
// 자기소개를 하기위해 introduce를 호출하면 자신의 내부에 있는 참조 타입 변수를 획득
bs = nil // 디이니셜라이저 호출이 안됨. 메모리 누수중

/* 획득목록Capture list*/
// 클로저 내부에서 참조 타입을 획득하는 규칙을 제시하는 기능
// 위의 문제는 클로저 내부의 self를 약한참조로 지정해서 문제를 해결가능
// 매개변수 목록 이전 위치에 작성하며, 참조 방식과 참조 대상을 대괄호로 둘러싼 목록 형식으로 작성
// 획득목록 뒤에는 in 키워드를 써준다
class SimpleClass {
    var value: Int = 0
}

var x: SimpleClass? = SimpleClass()
var y = SimpleClass()

let closure = { [weak x, unowned y] in
    print(x?.value, y.value)
}

x = nil
y.value = 10

closure() // nil 10
