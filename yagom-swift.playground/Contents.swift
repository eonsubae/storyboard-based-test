import UIKit

// 접근제어Access Control
// 코드끼리 상호작용을 할 때 파일 간 또는 모듈 간에 접근을 제한할 수 있는 기능
// 코드의 상세 구현은 숨기고 허용된 기능만 사용하는 인터페이스를 제공할 수 있다

/* 공개 접근수준 - public */
// public 키워드로 접근 수준이 지정된 요소는 모든 곳에서 사용할 수 있다
// 주로 프레임워크에서 외부와 연결될 인터페이스를 구현하는 데 많이 쓰인다

/* 스위프트 표준 라이브러리에 구현되어 있는 Bool 타입 */
/*
public struct Bool {
    public init()
}
*/

/* 개방 접근수준 - open */
// 공개 접근수준보다 접근수준이 높다
// 클래스와 클래스의 멤버에서만 사용이 가능하다
// 클래스가 정의된 모듈 밖의 다른 모듈에서도 상속할 수 있다
// 클래스 멤버가 정의된 모듈 밖에 다른 모듈에서도 재정의할 수 있다
// 클래스를 개방 접근수준으로 명시하는 것은 그 클래스를 다른 모듈에서도
// 부모클래스로 사용하겠다는 목적으로 설계하고 코드를 작성했음을 의미한다
/* Foundation 프레임워크에 정의된 개방 접근 수준의 NSString 클래스
open class NSString: NSObject, NSCopying, NSMutableCopying, NSSecureCoding {
    open var length: Int { get }
    open func character(at index: Int) -> unichar
    public init()
    public init?(coder aDecoder: NSCoder)
}
*/

/* 내부 접근수준 - internal */
// 기본적으로 모든 요소에 암묵적으로 지정되는 접근수준이다
// 내부 접근수준으로 지정된 요소는 소스파일에 속해 있는 모듈 어디에서든 쓰일 수 있다
// 다만 외부 모듈에서는 접근할 수 없다

/* 파일외부비공개 접근수준 - fileprivate */
// 요소가 구현된 소스파일 내부에서만 사용할 수 있다

/* 비공개 접근수준 - private */
// 기능을 정의한 범위 내에서만 사용이 가능하다
// 같은 소스파일 안에 구현된 다른 타입에서도 접근이 불가능하다

/* 접근제어 구현 */
open class OpenClass {
    open var openProperty: Int = 0
    public var publicProperty: Int = 0
    internal var internalProperty: Int = 0
    fileprivate var filePrivateProperty: Int = 0
    private var privateProperty: Int = 0
    
    open func openMethod() {}
    public func publicMethod() {}
    internal func internalMethod() {}
    fileprivate func fileprivateMethod() {}
    private func privateMethod() {}
}

public class PublicClass {}
public struct PublicStruct {}
public enum PublicEnum {}
public var publicVariable = 0
public let publicConstant = 0
public func publicFunction() {}

// internal 키워드는 생략해도 무방하다
internal class InternalClass {}
internal struct InternalStruct {}
internal enum InternalEnum {}
internal var internalVariable = 0
internal let internalConstant = 0
internal func internalFunction() {}

fileprivate class FilePrivateClass {}
fileprivate struct FilePrivateStruct {}
fileprivate enum FilePrivateEnum {}
fileprivate var filePrivateVariable = 0
fileprivate let filePrivateConstant = 0
fileprivate func filePrivateFunction() {}

private class PrivateClass {}
private struct PrivateStruct {}
private enum PrivateEnum {}
private var privateVariable = 0
private let privateConstant = 0
private func privateFunction() {}

/* 접근제어 구현 참고사항 */
// 1. 상위 요소보다 하위 요소가 더 높은 접근수준을 가질 수 없다
// ex1.
private class AClass {
    // public 키워드로 공개 접근수준을 부여해도 AClass가 비공개 접근수준이므로
    // 이 메서드의 접근수준도 비공개 접근수준으로 취급된다
    public func someMethod() {}
}

/*
 AClass의 접근수준이 비공개 접근수준이므로
 공개접근수준의 함수의 매개변수나 값 타입으로 사용할 수 없다
public func someFuntion(a: AClass) -> AClass {
    return a
}
*/

/* 튜플의 접근수준 부여 */
internal class InternalClass2 {} // 내부 접근수준 클래스
private struct PrivateStruct2 {} // 비공개 접근수준 구조체

// 요소로 사용되는 InterClass와 PrivateStruct의 접근수준이
// publicTuple보다 낮기 때문에 사용할 수 없다
/*
public var publicTuple: (first: InternalClass2, second: PrivateStruct2)
    = (InternalClass2(), PrivateStruct2())
*/
 
// 요소로 사용되는 InterClass와 PrivateStruct의 접근수준이
// publicTuple보다 같거나 높기 때문에 사용할 수 있다
private var privateTuple: (first: InternalClass2, second: PrivateStruct2)
    = (InternalClass2(), PrivateStruct2())

/* 접근수준에 따른 접근 결과 */
// AClass.swift파일과 Common.swift 파일이 같은 모듈에 속해 있을 경우

// AClass.swift
class AClass2 {
    func internalMethod() {}
    fileprivate func filePrivateMethod() {}
    var internalProperty = 0
    fileprivate var filePrivateProperty = 0
}

// Common.swift
let aInstance: AClass2 = AClass2()
aInstance.internalMethod() // 같은 모듈이므로 호출 가능
//aInstance.filePrivateMethod() // 다른 파일이므로 호출 불가 - 오류
aInstance.internalProperty = 1 // 같은 모듈이므로 접근 가능
//aInstance.filePrivateProperty = 1 // // 다른 파일이므로 접근 불가 - 오류

/* 열거형의 접근수준 */
// 열거형은 케이스별 접근수준은 설정할 수 없다
// 각 케이스는 열거형 자체의 접근수준을 따른다
// 또한 열거형의 원시 값 타입으로 열거형의 접근수준보다 낮은 접근수준의 타입이 올 수는 없다
// 연관 값의 타입 또한 마찬가지다
private typealias PointValue = Int

// 오류 - PointValue가 Point보다 접근수준이 낮기 때문에 원시 값으로 사용할 수 없다
/*
enum Point: PointValue {
    case x, y
}
*/

/* private와 fileprivate */
// fileprivate는 같은 파일의 어떤 코드에서도 접근할 수 있다
// private는 같은 파일의 다른 타입에서는 접근할 수 없다
// private도 자신을 확장하는 익스텐션을 사용하는 경우에는 접근이 가능하다
public struct SomeType {
    private var privateVariable = 0
    fileprivate var fileprivateVariable = 0
}

// 같은 타입의 익스텐션에서는 private 요소에 접근 가능
extension SomeType {
    public func publicMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
    
    private func privateMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
    
    fileprivate func fileprivateMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
}

struct AnotherType {
    var someInstance: SomeType = SomeType()
    
    mutating func someMethod() {
        // public 접근수준에는 어디서든 접근 가능
        self.someInstance.publicMethod() // 0, 0
        
        // 같은 파일에 속해 있는 코드이므로 fileprivate 접근수준 요소에 접근 가능
        self.someInstance.fileprivateVariable = 100
        self.someInstance.fileprivateMethod() // 0, 100
        
        // 다른 타입 내부의 코드이므로 private 요소에 접근 불가! 오류!
//        self.someInstance.privateVariable = 100
//        self.someInstance.privateMethod()
    }
}

var anotherInstance: AnotherType = AnotherType()
anotherInstance.someMethod()

/* 읽기 전용 구현 */
// 설정자만 더 낮은 접근 수준을 갖게 만들어 변경이 불가능하도록 만들 수 있다
public struct SomeType2 {
    // 비공개 접근수준 저장 프로퍼티 count
    private var count: Int = 0
    
    // 공개 접근수준 저장 프로퍼티 publicStoredProperty
    public var publicStoredProperty: Int = 0
    
    // 공개 접근수준 저장 프로퍼티 publicGetOnlyStoredProperty
    // 설정자set는 비공개 접근수준
    public private(set) var publicGetOnlyStoredProperty: Int = 0
    
    // 내부 접근수준 저장 프로퍼티 internalComputedProperty
    internal var internalComputedProperty: Int {
        get {
            return count
        }
        set {
            count += 1
        }
    }
    
    // 내부 접근수준 저장 프로퍼티 internalGetOnlyStoredProperty
    // 설정자set는 비공개 접근수준
    internal private(set) var internalGetOnlyStoredProperty: Int {
        get {
            return count
        }
        set {
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    public subscript() -> Int {
        get {
            return count
        }
        set {
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    // 설정자set는 내부 접근수준
    public internal(set) subscript(some: Int) -> Int {
        get {
            return count
        }
        set {
            count += 1
        }
    }
}

var someInstance2: SomeType2 = SomeType2()

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance2.publicStoredProperty) // 0
someInstance2.publicStoredProperty = 100

// 외부에서 접근자만 사용 가능
print(someInstance2.publicGetOnlyStoredProperty) // 0
//someInstance2.publicGetOnlyStoredProperty = 100 // 오류 발생

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance2.internalComputedProperty) // 0
someInstance2.internalComputedProperty = 100

// 외부에서 접근자만 사용 가능
print(someInstance2.internalGetOnlyStoredProperty) // 1
//someInstance2.internalGetOnlyStoredProperty = 100 // 오류 발생

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance2[]) // 1
someInstance2[] = 100

// 외부에서 접근자만, 같은 모듈 내에서는 설정자도 사용 가능
print(someInstance2[0]) // 2
someInstance2[0] = 100
