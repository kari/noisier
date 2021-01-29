//
//  LCG.swift
//  noisier
//
//  Created by Kari Silvennoinen on 08.07.2018.
//  Copyright © 2018 Kalifi.org. All rights reserved.
//

import Foundation

class LinearCongruentialGenerator {
    
    var state = 0 //seed of 0 by default
    let a, c, m, shift: Int
    
    //we will use microsoft random by default
    init() {
        self.a = 214013
        self.c = 2531011
        self.m = Int(pow(2.0, 31.0)) //2^31 or 2147483648
        self.shift = 16
    }
    
    init(a: Int, c: Int, m: Int, shift: Int) {
        self.a = a
        self.c = c
        self.m = m //2^31 or 2147483648
        self.shift = shift
    }
    
    func seed(seed: Int) -> Void {
        state = seed;
    }
    
    func random() -> Int {
        state = (a * state + c) % m
        return state >> shift
    }
    
    func nextInt() -> Int {
        return random()
    }
}
