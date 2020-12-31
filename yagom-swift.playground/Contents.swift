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
