import UIKit

// Float이 수용할 수 있는 범위를 넘어선다
// 자신이 감당할 수 있는 만큼만 남기므로 정확도가 떨어진다
// 6자리의 숫자까지만 표현 가능
var floatValue: Float = 1234567890.1

// Double은 충분히 수용할 수 있다
// 최소 15자리의 십진수를 표현 가능
let doubleValue: Double = 1234567890.1

print("floatValue: \(floatValue) doubleValue: \(doubleValue)") // floatValue: 1.234568e+09 doubleValue: 1234567890.1

// float이 수용할 수 있는 값으로 변경
floatValue = 123456.1

print(floatValue) // 123456.1

// 임의의 숫자를 만드는 random 메서드
Int.random(in: -100...100) // -100부터 100까지의 정수를 랜덤으로 선택
UInt.random(in: 30...60) // 30부터 60까지의 정수를 랜덤으로 선택
Double.random(in: 1.5...4.3) // 1.5부터 4.3까지의 실수를 랜덤으로 선택
Float.random(in: -0.5...1.5) // -0.5부터 1.5까지의 실수를 랜덤으로 선택
