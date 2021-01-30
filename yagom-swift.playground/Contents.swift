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

es = nil // Person 인스턴스의 참조 횟수 : 1
room = nil  // Room 인스턴스의 참조 횟수 : 0
// Room 505 is being deinitialized
