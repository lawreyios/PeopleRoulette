//
//  Array+Darwin.swift
//  PeopleRoulette
//
//  Created by Lawrey on 10/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Darwin

extension Collection {
    
    /**
     * Returns a random element of the Array or nil if the Array is empty.
     */
    var sample : Element? {
        guard !isEmpty else { return nil }
        let offset = arc4random_uniform(numericCast(count))
        let idx = index(startIndex, offsetBy: numericCast(offset))
        return self[idx]
    }
    
    /**
     * Returns `count` random elements from the array.
     * If there are not enough elements in the Array, a smaller Array is returned.
     * Elements will not be returned twice except when there are duplicate elements in the original Array.
     */
    func sample(_ count : UInt) -> [Element] {
        let sampleCount = Swift.min(numericCast(count), count)
        
        var elements = Array(self)
        var samples : [Element] = []
        
        while samples.count < sampleCount {
            let idx = (0..<elements.count).sample!
            samples.append(elements.remove(at: idx))
        }
        
        return samples
    }
    
}
