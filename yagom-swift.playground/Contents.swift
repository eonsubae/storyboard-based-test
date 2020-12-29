import UIKit

// 메서드
// 특정 타입에 대한 함수

/* 인스턴스 메서드 */
// 특정 타입의 인스턴스에 속한 함수
// 클래스와 인스턴스 메서드
class LevelClass {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    func levelDown() {
        print("Level Down!")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    func reset() {
        print("Reset!")
        level = 0
    }
}

var levelClassInstance: LevelClass = LevelClass()
levelClassInstance.levelUp()
levelClassInstance.levelDown()
levelClassInstance.levelDown()
levelClassInstance.jumpLevel(to: 3)

// 구조체와 열거형의 인스턴스 메서드
// 참조 타입인 클래스와 다르게 값 타입의 인스턴스 메서드에는
// mutating 키워드를 붙여서 해당 메서드가 인스턴스 내부의 값을 변경한다는 것을 명시해야 한다
struct LevelStruct {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func levelDown() {
        print("Level Down!")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    mutating func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    mutating func reset() {
        print("Reset!")
        level = 0
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()
levelStructInstance.levelDown()
levelStructInstance.levelDown()
levelStructInstance.jumpLevel(to: 3)

/* self 프로퍼티 */
// 인스턴스 자기 자신을 가르키는 프로퍼티
// 인스턴스를 더 명확하게 지칭하고 싶을 때 사용
// self를 사용하지 않으면 인스턴스 메서드 안에서는
// 지역변수, 메서드의 매개변수를 먼저 찾고 없으면 인스턴스의 프로퍼티를 찾는다
// self를 명시하면 인스턴스 프로퍼티를 바로 찾는다
class LevelClass2 {
    var level: Int = 0
    
    func jumpLevel(to level: Int) {
        print("Jump to \(level)")
        self.level = level
    }
}

/* 타입 메서드 */
// 타입 자체에서 호출이 가능한 메서드
// 메서드 앞에 static이나 class를 붙여준다
// static을 붙이면 오버라이딩이 불가능하고, class를 붙이면 오버라이딩이 가능하다
class AClass {
    static func staticTypeMethod() {
        print("AClass staticTypeMethod")
    }
    
    class func classTypeMethod() {
        print("AClass classTypeMethod")
    }
}

class BClass: AClass {
    /*
     // 오류 발생
     override static func staticTypeMethod() {
     
     }
    */
    override class func classTypeMethod() {
        print("BClass classTypeMethod")
    }
}

AClass.staticTypeMethod() // AClass staticTypeMethod
AClass.classTypeMethod() // AClass classTypeMethod
BClass.classTypeMethod() // BClass classTypeMethod

/* 타입 프로퍼티와 타입 메서드의 사용 */
struct SystemVolume {
    static var volume: Int = 5
    
    static func mute() {
        self.volume = 0 // SystemVolume.volume = 0 과 같은 표현이다
    }
}

class Navigation {
    var volume: Int = 5
    
    func guideWay() {
        SystemVolume.mute()
    }
    
    func finishGuideWay() {
        SystemVolume.volume = self.volume
    }
}

SystemVolume.volume = 10

let myNavi: Navigation = Navigation()

myNavi.guideWay()
print(SystemVolume.volume) // 0

myNavi.finishGuideWay()
print(SystemVolume.volume) // 5
