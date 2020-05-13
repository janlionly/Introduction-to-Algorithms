//
//  main.swift
//  Sorts
//
//  Created by janlionly<jan_ron@qq.com> on 2020/5/13.
//  Copyright © 2020 Janlionly. All rights reserved.
//

import Foundation

struct Sorts {
    // 1. 插入排序
    func insertionSort(array: inout [Int]) {
        for j in 1..<array.count {
            let key = array[j]
            var i = j - 1
            
            // move forward to find target index to insert
            while i >= 0 && array[i] > key {
                array[i + 1] = array[i]
                i = i - 1
            }
            array[i + 1] = key
        }
    }
    
    // 2. 归并排序
    func mergeSort(array: inout [Int]) {
        mergeSort(&array, leftIndex: 0, rightIndex: array.count - 1)
    }
    
    private func mergeSort(_ array: inout [Int], leftIndex: Int, rightIndex: Int) {
        if leftIndex == rightIndex {
            return
        }
        let midIndex = (rightIndex + leftIndex)/2
        mergeSort(&array, leftIndex: leftIndex, rightIndex: midIndex)
        mergeSort(&array, leftIndex: midIndex + 1, rightIndex: rightIndex)
        merge(&array, leftIndex, midIndex, rightIndex)
    }
    
    private func merge(_ array: inout [Int], _ leftIndex: Int, _ midIndex: Int, _ rightIndex: Int) {
        let max = Int.max
        var lefts = Array(array[leftIndex...midIndex])
        lefts.append(max)
        var rights = Array(array[midIndex + 1...rightIndex])
        rights.append(max)
        
//        print("Index(left:\(leftIndex),mid:\(midIndex),right:\(rightIndex)) Arr:\(array)")
//        print("leftArr:\(array[leftIndex...midIndex]), rightArr:\(array[midIndex+1...rightIndex])")
        
        var i = 0
        var j = 0
        for t in leftIndex...rightIndex {
            if lefts[i] < rights[j] {
                array[t] = lefts[i]
                i = i + 1
            } else {
                array[t] = rights[j]
                j = j + 1
            }
        }
        
//        print("After merge arr:\(array[leftIndex...rightIndex])\n")
    }
}


// Main
let count = 30000
var A: [Int] = [Int](repeating: 0, count: count)

print("Init array(\(count))")
for i in 0..<count {
    A[i] = Int(arc4random() % UInt32(count))
}

print("Starting sorting...")
let sorter = Sorts()
let startTime = Date()
//sorter.insertionSort(array: &A)
sorter.mergeSort(array: &A)
let endTime = Date()

print("Sort result:\(A), \nProcess seconds:\(endTime.timeIntervalSince(startTime))")

