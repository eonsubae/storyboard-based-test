import UIKit

let name: String = "esbae" // let으로 상수를 선언
var age: Int = 30 // 타입 지정
var job = "iOS Programmer" // 타입 추론 String
let height = 181.5 // let으로 상수를 선언
age = 31 // var는 변수이므로 값을 변경할 수 있다
job = "Writer"
// name = "sjfld" let은 상수이므로 변경하려하면 에러가 발생

print("저의 이름은 \(name)이고, 나이는 \(age)세이며, 직업은 \(job)입니다. 비밀이지만 키는 \(height)센티미터입니다.")
