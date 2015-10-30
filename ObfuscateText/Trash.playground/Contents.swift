//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let ivInt = Int(arc4random_uniform(10))


func random64(upper_bound: UInt64) -> UInt64 {
    
    // Generate 64-bit random number:
    var rnd : UInt64 = 0
    arc4random_buf(&rnd, sizeofValue(rnd))
    
    return rnd % upper_bound
}


