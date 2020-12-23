import UIKit

// Charactert는 문자 한 개를 저장하는 데이터 타입이다
let alphabetA: Character = "A"
print(alphabetA) // A

let commandCharacter: Character = "❤️"
print(commandCharacter) // ❤️ 스위프트는 유니코드9를 사용하므로 영어는 물론 유니코드에서 지원하는 모든 언어 및 이모티콘을 사용할 수 있다

// String은 나열된 문자인 문자열을 저장하는 데이터 타입이다 캐릭터와 마찬가지로 유니코드9를 사용한다
let name: String = "esbae"

// 이니셜라이저를 사용해 빈문자열을 생성
// var 키워드를 사용해 변수를 생성했으므로 문자열의 수정이 가능하다
var introduce: String = String()

// append메서드를 사용하여 문자열을 후방으로 이어붙일 수 있다
introduce.append("제 이름은")

// + 연산자를 통해서도 문자열을 이어 붙일 수 있다
introduce = introduce + " " + name + "입니다."

print(introduce) // 제 이름은 esbae입니다.

// 문자열의 길이를 세기
print("name의 글자 수 : \(name.count)") // 5

// 빈 문자열인지 확인
print("introduce가 비어있습니까?: \(introduce.isEmpty)") // false

// 유니코드의 스칼라값을 사용하면 값에 해당하는 표현이 출력된다
let unicodeScalarValue: String = "\u{2665}"
print(unicodeScalarValue) // ♥
