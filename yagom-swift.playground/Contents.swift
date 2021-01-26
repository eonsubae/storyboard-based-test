/* 모나드 */
// 순서가 있는 연산을 처리하는 디자인 패턴
// 혹은 수학의 범주론의 한 개념
// 프로그래밍에서의 모나드는 범주론의 개념을 완벽히 따르지는 않는다

/* 모나드의 조건 */
// 1. 타입을 인자로 받는 타입(특정 타입의 값을 포장)
// 2. 특정 타입의 값을 포장한 것을 반환하는 함수(메서드)가 존재
// 3. 포장된 값을 변환하여 같은 형태로 포장하는 함수(메서드)가 존재

/* 컨텍스트 */
// 컨텐츠를 담은 무언가를 컨텍스트라 한다 ex)물을 담고있는 물컵
// ex. 옵셔널
/*
  옵셔널은 열거형으로 구현됨
  옵셔널에 값이 없다면 열거형의 .none case로,
  값이 있다면 .some case로 값을 지닌다
*/

// 순수값을 전달받아 3을 더해 반환하는 함수
// 옵셔널을 인자로 받을 수 없다
func addThree(_ num: Int) -> Int {
    return num + 3
}

addThree(2) // 5
//addThree(Optional(2)) // 에러 발생

/* 함수 객체Functor */
// 고차함수 map은 컨테이너의 값을 변형시킨다
// 그리고 옵셔널은 컨테이너를 가지므로 map을 사용할 수 있다
// 옵셔널에 map을 사용하면 앞서 만든 함수를 사용할 수 있다
Optional(2).map(addThree) // Optional(5)

var value: Int? = 2
value.map { $0 + 3 } // Optional(5)
value = nil
value.map { $0 + 3 } // nil(==Optional<Int>.none)

/* 모나드 */
// 함수객체 중 자신의 컨텍스트와 같은 컨텍스트의 형태로 맵핑할 수 있는 함수객체를 닫힌 함수객체Endofunctor라고 한다
// 모나드는 닫힌 함수객체다
// 함수객체는 포장된 값에 함수를 적용할 수 있다
// 이 매핑의 결과가 함수객체와 같은 컨텍스트를 반환하는 함수객체를 모나드라 한다
// 이런 매핑을 수행하도록 flatMap메서드를 사용한다

func doubledEven(_ num: Int) -> Int? {
    if num.isMultiple(of: 2) {
        return num * 2
    }
    return nil
}

Optional(3).flatMap(doubledEven) // nil(==Optional<Int>.none)
// Optional 컨텍스트에서 값(3) 추출 -> 추출한 값을 doubledEven함수에 전달 -> 짝수가 아니므로 빈 컨텍스트 반환
// 이렇게만 보면 map과 무슨 차이인지 알기가 어렵다
// 하지만 플랫맵은 맵과 다르게 컨텍스트 내부의 컨텍스트를 모두 같은 위상으로 평평하게 펼쳐준다는 차이가 있다

// 맵과 컴팩트맵
// 컴팩트맵의 사용법은 플랫맵과 같다. 다만 좀 더 분명한 뜻을 나타내기 위해 compactMap이라는 이름을 쓴다
let optionals: [Int?] = [1, 2, nil, 5]

let mapped: [Int?] = optionals.map { $0 }
let compactMapped: [Int] = optionals.compactMap { $0 }

print(mapped) // [Optional(1), Optional(2), nil, Optional(5)]
print(compactMapped) // [1, 2, 5]
// optionals은 Array라는 컨테이너 내부에 Optional이라는 컨테이너들이 여러개 있는 형태다
// map은 Array내부에 값이 있기만 하면 그 값을 클로저에서 실행하고 다시 담기만 한다
// 그러나 flatMap은 알아서 내부 컨테이너의 값까지 추출해낸다

/* 삼중 컨테이너에서 맵과 플랫맵(컴팩트맵)의 차이 */
let multipleContainer = [[1, 2, Optional.none], [3, Optional.none], [4, 5, Optional.none]]

let mappedMultipleContainer = multipleContainer.map { $0.map { $0 } }
let flatmappedMultipleContainer = multipleContainer.flatMap { $0.flatMap { $0 } }

print(mappedMultipleContainer) // [[Optional(1), Optional(2), nil], [Optional(3), nil], [Optional(4), Optional(5), nil]]
print(flatmappedMultipleContainer) // [1, 2, 3, 4, 5]
// 플랫맵은 내부의 값을 1차원적으로 펼쳐놓는 동일한 위상에 놓는 작업까지 수행한다
// 플랫맵은 체이닝 중간에 연산에 실패하거나 값이 없는 경우 별도의 예외 처리 없이 빈 컨테이너를 반환한다
