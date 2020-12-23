import UIKit

// Any, AnyObject, nil
var someVar: Any = "esbae" // Any는 어떤 타입의 변수라도 할당이 가능함을 의미한다
someVar = 50
someVar = 100.1
// AnyObject는 Any보다 조금 더 한정적으로 클래스의 인스턴스에만 사용할 수 있다
// 될 수 있으면 Any 혹은 AnyObject는 사용하지 않는 편이 좋다
// 매번 타입 변환을 해야하는 가능성도 있고, 예기치 못한 에러의 위험도 높기 때문이다
// 될 수 있으면 Any, AnyObject, 타입 추론보다는 타입을 항상 명시하는 편이 좋다

// nil은 특정 타입이 아닌 '없음'을 나타내는 의미로 사용된다
// 변수 또는 상수에 값이 없을 때 nil을 사용한다

