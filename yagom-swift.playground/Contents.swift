import UIKit

// 문자열 타입의 다양한 기능
let hello: String = "Hello"
let esbae: String = "esbae"
var greeting: String = hello + " " + esbae + "!"
print(greeting) // Hello esbae!

greeting = hello
greeting += " "
greeting += esbae
greeting += "!"
print(greeting) // Hello esbae!

// 연산자를 통한 문자열 비교
var isSameString: Bool = false

isSameString = hello == "Hello"
print(isSameString) // true

isSameString = hello == "hello"
print(isSameString) // false

// 메서드를 통한 접두어, 접미어 확인
var hasPrefix: Bool = false
hasPrefix = hello.hasPrefix("He") // He라는 접두어를 가지고 있는지를 확인해서 불리언 타입을 할당
print(hasPrefix) // true

var hasSuffix: Bool = false
hasSuffix = hello.hasSuffix("llo") // llo라는 접미어를 가지고 있는지를 확인해서 불리언 타입을 할당
print(hasSuffix) // true

// 메서드를 통한 대소문자 변환
var convertedString: String = ""
convertedString = hello.uppercased()
print(convertedString) // HELLO

convertedString = hello.lowercased()
print(convertedString) // hello

// 코드상에서 여러 줄의 문자열을 쓰기
greeting = """
안녕하세요 저는 배언수입니다.
스위프트 잘하고 싶어요!
잘 부탁합니다!
"""

print(greeting)
