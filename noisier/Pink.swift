/*
 patest_pink.c
 
 Generate Pink Noise using Gardner method.
 Optimization suggested by James McCartney uses a tree
 to select which random value to replace.
 
 Tree is generated by counting trailing zeros in an increasing index.
 When the index is zero, no random number is selected.
 
 Author: Phil Burk, http://www.softsynth.com
 
 Revision History:
 
 Copyleft 1999 Phil Burk - No rights reserved.
 */
import Foundation

struct PinkNoise {
    var rows = [Int]()
    var runningSum: Int
    var index: Int
    let indexMask: Int
    let scalar: Double

    init(numRows: Int) {
        self.index = 0
        self.indexMask = (1 << numRows) - 1
        let pmax = (numRows + 1) * Int(Int32.max)
        self.scalar = 1.0 / Double(pmax)
        self.runningSum = 0
        self.rows = Array(repeating: 0, count: numRows)
    }
    
    mutating func generate() -> Double {
        var newRandom: Int
        var sum: Int
        var output: Double
        
        /* Increment and mask index. */
        self.index = (self.index + 1) & self.indexMask
        
        /* If index is zero, don't update any random values. */
        if (self.index != 0) {
            let numZeros = self.index.trailingZeroBitCount
            
            /* Replace the indexed ROWS random value.
             * Subtract and add back to RunningSum instead of adding all the random
             * values together. Only one changes each time.
             */
            self.runningSum -= self.rows[numZeros]
            newRandom = Int(arc4random_uniform(UInt32.max))-Int(Int32.max)
            self.runningSum += newRandom
            self.rows[numZeros] = newRandom
            // NSLog("newRandom: \(newRandom), numzeros: \(numZeros), rows: \(self.rows[numZeros])")
        }
        
        /* Add extra white noise value. */
        newRandom = Int(arc4random_uniform(UInt32.max))-Int(Int32.max)
        // NSLog("newRandom: \(newRandom)")
        sum = self.runningSum + newRandom
        
        /* Scale to range of -1.0 to 0.9999. */
        output = self.scalar * Double(sum)
        
        return output
    }
}
