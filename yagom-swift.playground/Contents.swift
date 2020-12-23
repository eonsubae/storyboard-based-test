import UIKit

var name: String = "esbae" // 타입 지정
var age: Int = 30 // 타입 지정
var job = "iOS Programmer" // 타입 추론 String
var height = 181.5 // 타입 추론 Double
age = 31 // var는 변수이므로 값을 변경할 수 있다
job = "Writer"

print("저의 이름은 \(name)이고, 나이는 \(age)세이며, 직업은 \(job)입니다. 비밀이지만 키는 \(height)센티미터입니다.")
