/* 옵셔널 체이닝 */
// 옵셔널에 속해 있는 nil일지도 모르는 프로퍼티, 메서드, 서브스크립션 등을 가져오거나 호출할 때 사용
// 옵셔널에 값이 있다면 프로퍼티, 메서드, 서브스크립션 등을 호출할 수 있고
// 옵셔널이 nil이라면 프로퍼티, 메서드, 서브스크립션 등은 nil을 반환한다

// 옵셔널을 반복 사용하여 체인처럼 꼬리를 물고 있는 모양을 하고 있으므로 옵셔널 체이닝이라고 한다
// 중첩된 옵셔널 중 하나라도 값이 존재하지 않으면 nil을 반환한다
// 프로퍼티, 메서드, 서브스크립션을 호출하고 싶은 옵셔널 변수나 상수 뒤에 물음표(?)를 붙여 표현한다
// 옵셔널 체이닝의 반환 값은 nil이 반환될 가능성이 있으므로 언제나 옵셔널이다

class Room {
    var number: Int
    
    init(number: Int) {
        self.number = number
    }
}

class Building {
    var name: String
    var room: Room?
    
    init(name: String) {
        self.name = name
    }
}

struct Address {
    var province: String
    var city: String
    var street: String
    var building: Building?
    var detailAddress: String?
}

class Person {
    var name: String
    var address: Address?
    
    init(name: String) {
        self.name = name
    }
}

let esbae: Person = Person(name: "esbae")
let esbaeRoomViaOptionalChaining: Int? = esbae.address?.building?.room?.number // nil
// let esbaeRoomViaOptionalUnwrapping: Int = esbae.address!.building!.room!.number // 오류 발생

/* 옵셔널 바인딩을 사용 */
var roomNumber: Int? = nil

if let esbaeAddress: Address = esbae.address {
    if let esbaeBuilding: Building = esbaeAddress.building {
        if let esbaeRoom: Room = esbaeBuilding.room {
            roomNumber = esbaeRoom.number
        }
    }
}

if let number: Int = roomNumber {
    print(number)
} else {
    print("Can not find room number")
}

/* 옵셔널 체이닝으로 보다 간단히 표현 */
if let roomNumber: Int = esbae.address?.building?.room?.number {
    print(roomNumber)
} else {
    print("Can not find room number")
}

/* 옵셔널 체이닝을 통한 값 할당 */
esbae.address = Address(province: "서울", city: "강동구 명일동", street: "명일로", building: nil, detailAddress: nil)
esbae.address?.building = Building(name: "JG")
esbae.address?.building?.room = Room(number: 0)
esbae.address?.building?.room?.number = 203

print(esbae.address?.building?.room?.number) // Optional(203)

extension Address {
    init(province: String, city: String, street: String) {
        self.province = province
        self.city = city
        self.street = street
    }
    
    func fullAddress() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo: Building = self.building {
            restAddress = buildingInfo.name
        } else if let detail = self.detailAddress {
            restAddress = detail
        }
        
        if let rest: String = restAddress {
            var fullAddress: String = self.province
            
            fullAddress += " " + self.city
            fullAddress += " " + self.street
            fullAddress += " " + rest
            
            return fullAddress
        } else {
            return nil
        }
    }
    
    func printAddress() {
        if let address: String = self.fullAddress() {
            print(address)
        }
    }
}

esbae.address?.fullAddress()?.isEmpty // false
esbae.address?.printAddress() // 서울 강동구 명일동 명일로 JG

/* guard를 이용한 빠른 종료 */
// guard 구문은 if와 유사하게 Bool 타입의 값으로 동작한다
// guard 뒤에 따라붙는 코드의 실행 결과가 true일 때 코드가 계속 실행된다
// 항상 뒤에 else 문이 따라와야 한다

/*
 guard Bool 타입 값 else {
     예외사항 실행문
     제어문 전환 명령어
 }
*/

/* if와 guard 비교 */
for i in 0...3 {
    if i == 2 {
        print(i)
    } else {
        continue
    }
}

for i in 0...3 {
    guard i == 2 else {
        continue
    }
    print(i)
}

/* guard 구문의 옵셔널 바인딩 활용 */
func greet(_ person: [String: String]) {
    guard let name: String = person["name"] else {
        return
    }
    
    print("Hello \(name)")
    
    guard let location: String = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weahter is nice in \(location)")
}

var personInfo: [String: String] = [String: String]()
personInfo["name"] = "Jenny"

greet(personInfo)
// Hello Jenny
// I hope the weather is nice near you

personInfo["location"] = "Korea"
// Hello Jenny
// I hope the weather is nice in Korea

/* fullAccess를 guard를 사용해 리팩토링 */
extension Address {
    func fullAccess() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo: Building = self.building {
            restAddress = buildingInfo.name
        } else if let detail = self.detailAddress {
            restAddress = detail
        }
        
        guard let rest: String = restAddress else {
            return nil
        }
            
        var fullAddress: String = self.province
        fullAddress += " " + self.city
        fullAddress += " " + self.street
        fullAddress += " " + rest
            
        return fullAddress
    }
}

/* ,로 추가조건을 나열하기 */
func enterClub(name: String?, age: Int?) {
    guard let name: String = name, let age: Int = age, age > 19,
        name.isEmpty == false else {
        print("You are too young to enter the club")
        return
    }
    
    print("Welcome \(name)!")
}

/* guard 구문은 return, break, continue, throw 등의 제어문 전환 명령을 쓸 수 없으면 사용이 불가능하다 */
let first: Int = 3
let second: Int = 5

/*
guard first > second else {
    // 여기에 들어올 제어문 전환 명령은 딱히 없다.
}
*/
