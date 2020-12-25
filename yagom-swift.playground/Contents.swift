import UIKit

// 컬렉션(Array, Dictionary, Set)
// 컬렉션에서 임의의 요소 추출, 뒤섞기

var array: [Int] = [0, 1, 2, 3, 4]
var set: Set<Int> = [0, 1, 2, 3, 4]
var dictionary: [String: Int] = ["a": 1, "b": 2, "c": 3]
var string: String = "string"

print(array.randomElement()) // 임의의 요소가 추출됨
print(array.shuffled()) // 배열 안의 요소가 뒤섞여서 출력된다. 이 때 array 내부의 요소는 그대로다
print(array) // [0, 1, 2, 3, 4]
array.shuffle() // 배열 자체를 뒤섞기
print(array) // 뒤섞인 배열이 출력된다

print(set.shuffled()) // 세트를 뒤섞으면 배열로 반환된다
// set.shuffle() 오류가 발생. 세트는 순서가 없으므로 스스로 뒤섞기가 불가능
print(dictionary.shuffled()) // 딕셔너리를 뒤섞으면 (키, 값)이 쌍을 이룬 튜플의 배열이 반환된다
print(string.shuffled()) // String도 컬렉션이다. 순서가 뒤섞인 문자열의 배열이 출력된다
