import UIKit

var integer: Int = -100 // Int에는 음수 할당이 가능
let unsignedInt: UInt = 50 // UInt에는 양수만 할당 가능
let largeInteger: Int64 = Int64.max // 64비트의 정수
let smallUnsignedInteger: UInt8 = UInt8.max // 8비트의 양수인 정수만 할당 가능
//integer = unsignedInt // UInt를 Int에 할당할 수 없으므로 에러가 발생
integer = Int(unsignedInt) // 새로운 Int값을 생성해 할당하는 것은 가능
