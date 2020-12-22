import UIKit

struct BasicInfomartion {
    let name: String
    var age: Int
}

var esbaeInfo: BasicInfomartion = BasicInfomartion(name: "esbae", age: 30)

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

let esbae: Person = Person()
esbae.height = 182.5
esbae.weight = 75.3

print(esbaeInfo) // BasicInfomartion(name: "esbae", age: 30)
print("==============")
dump(esbaeInfo)
/*
 __lldb_expr_5.BasicInfomartion
 - name: "esbae"
 - age: 30
*/
